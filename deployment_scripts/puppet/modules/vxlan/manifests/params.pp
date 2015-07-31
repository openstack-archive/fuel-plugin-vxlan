class vxlan::params {
  $ml2_conf_file = '/etc/neutron/plugins/ml2/ml2_conf.ini'
  
  
  if $::osfamily == 'Debian' {
  
	$openvswitch_agent = 'p_neutron-plugin-openvswitch-agent'
	$openvswitch_agent_compute = 'neutron-plugin-openvswitch-agent'
  } elsif($::osfamily == 'RedHat') {

  	$openvswitch_agent = 'p_neutron-openvswitch-agent'
  	$openvswitch_agent_compute = 'neutron-openvswitch-agent'
  } else {
    fail("unsuported osfamily ${::osfamily}, currently Debian and Redhat are the only supported platforms")
  }
}
