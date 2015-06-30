# == Class: vxlan::compute
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
class vxlan::compute (
  $vxlan_port = 4789,
){
include vxlan::params


#add vxlan tunnel type to ovs and agent

  neutron_plugin_ml2 {
      'ml2/type_drivers': value => 'vxlan,flat,vlan,gre';
  }~> Service['neutron-plugin-openvswitch-agent']

  neutron_plugin_ml2 {
      'ml2/tenant_network_types': value => 'vxlan,flat,vlan,gre';
  }~> Service['neutron-plugin-openvswitch-agent']


  neutron_plugin_ml2 {
      'ovs/tunnel_type': value => 'vxlan,gre';
  }

  neutron_plugin_ml2 { 
      'agent/tunnel_types': value => 'vxlan,gre';
  }~> Service['neutron-plugin-openvswitch-agent']

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



  service { 'neutron-plugin-openvswitch-agent':
    ensure  => running,
    enable  => true,
  }


}
