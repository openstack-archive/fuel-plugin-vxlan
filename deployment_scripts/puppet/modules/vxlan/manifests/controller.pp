# == Class: vxlan
#
# Full description of class vxlan here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'vxlan':
#    
#  }
#
# === Authors
#
# Author Name <samuel.bartel@orange.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class vxlan::controller (
  $vxlan_port = 4789,
){
include vxlan::params


  neutron_router_interface { "router04:net04__subnet": 
    ensure => absent,  
  } 

  neutron_network { 'net04':
    ensure                    => absent,
  } 

  #update  ml2 configuration
  neutron_plugin_ml2 {
      'ml2/type_drivers': value => 'vxlan,flat,vlan,gre';
      'ml2/tenant_network_types': value => 'vxlan,flat,vlan,gre';
      'ovs/tunnel_type': value => 'vxlan,gre';
  }~> Service['neutron-server']

  
  class{'vxlan::neutron_services':}
  
  #add vxlan port to firewall
  class {'::firewall':}
  firewall { '334 notrack vxlan':
    port    => $vxlan_port,
    chain   => 'PREROUTING',
    table   => 'raw',
    proto   => 'udp',
    jump  => 'NOTRACK',
  }

  firewall { '335 accept vxlan port 4789':
    chain   => 'INPUT',
    table   => 'filter',
    port    => $vxlan_port,
    proto   => 'udp',
    action  => 'accept',
  }

  service { 'neutron-server':
    ensure  => running,
    enable  => true,
  }

}
