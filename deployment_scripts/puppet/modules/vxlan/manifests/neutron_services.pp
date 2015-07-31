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
class vxlan::neutron_services (){
include vxlan::params

    neutron_plugin_ml2 {
        'agent/tunnel_types': value => 'vxlan';
    } ~> Service['neutron-server']
    ->
    exec { "neutron-plugin-openvswitch-agent_restart":
      command => "/usr/sbin/crm resource restart $vxlan::params::openvswitch_agent",
    }->
    exec { "neutron-l3-agent_restart":
      command => "/usr/sbin/crm resource restart p_neutron-l3-agent",
    }

}
