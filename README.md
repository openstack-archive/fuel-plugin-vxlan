VXLAN plugin for Fuel
===================

VXLAN plugin
---------------

Overview
--------
By default the openstack environment is configured with gre or vlan segmentation type. This plugin allows to create vxlan private network.

This repo contains all necessary files to build vxlan Fuel plugin.

Requirements
------------

| Requirement                      | Version/Comment                                         |
|----------------------------------|---------------------------------------------------------|
| Mirantis Openstack compatibility | 6.0                                                     |
|----------------------------------|---------------------------------------------------------|


Recommendations
---------------

None.

Limitations
-----------

None.

Installation Guide
==================

Vxlan plugin installation
----------------------------

1. Clone the fuel-plugin repo from: https://github.com/stackforge/fuel-plugin-vxlan.git

    ``git clone``

2. Install the Fuel Plugin Builder:

    ``pip install fuel-plugin-builder``

3. Build vxlan Fuel plugin:

   ``fpb --build fuel-plugin-vxlan/``

4. The vxlan-<x.x.x>.fp file will be created in the plugin folder (fuel-plugin-vxlan)

5. Move this file to the Fuel Master node with secure copy (scp):

   ``scp vxlan-<x.x.x>.fp root@:<the_Fuel_Master_node_IP address>:/tmp``
   ``cd /tmp``

6. Install the vxlan plugin:

   ``fuel plugins --install vxlan-<x.x.x>.fp``

6. Plugin is ready to use and can be enabled on the Settings tab of the Fuel web UI.

User Guide
==========

https plugin configuration
-----------------------------

1. Create a new environment with the Fuel UI wizard with gre segmentation type selected

2. Add a node with the "Compute" role.

3. Click on the settings tab of the Fuel web UI

4. Scroll down the page, select the "vxlan plugin" checkbox



Deployment details
------------------

Configure neutron/ml2plugin to use vxlan as default segmentation type 
Configureboth controller and compute neutron/ml2plugin  to create vxlan tunneling
Restart neutron services


Known issues
------------

None.

Release Notes
-------------

**1.0.0**

* Initial release of the plugin



