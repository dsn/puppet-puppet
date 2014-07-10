####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet(#setup)
    * [What puppet affects](#what-puppet-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet](#beginning-with-puppet)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module is designed to provide quick and easy management of Puppet in Agent or Masterless Configurations.

##Module Description

The Puppet module provides a quick way to manage your Puppet Agents.

##Setup

###What puppet affects

* package/service/configuration files for Puppet
* puppet's configuration
* service sysconfig defaults
* replicate pluginsync in masterless

###Setup Requirements **OPTIONAL**

Requires 'puppetlabs-stdlib'

###Beginning with puppet

Clone this repository to your modulepath   

##Usage

### puppet::agent
The `puppet::agent` class is intended as a high-level abstraction to ease in the management of Puppet

**Parameters within `puppet::agent`:**

####`master`

The hostname or IP address of the database server (defaults to `puppet`).

####`environment`

The ruby / puppet environment (defaults to `production`).

####`pluginsync`

Whether plugins should be synced with the central server.
* Default: true
* Valid values: `true|false`

####`runinterval`

How often puppet agent applies the catalog. Note that a runinterval of 0 means “run continuously” rather than “never run.” If you want puppet agent to never run, you should start it with the --no-client option. This setting can be a time interval in seconds (30 or 30s), minutes (30m), hours (6h), days (2d), or years (5y).

* Default: 30m

Valid values are 
  $ensure               = $puppet::params::service_ensure,
  $enable               = $puppet::params::service_enable,
  $runinterval          = $puppet::params::runinterval,
  $graph                = $puppet::params::graph,
  $report               = $puppet::params::report,
  $reports              = $puppet::params::reports,
  $storeconfigs         = $puppet::params::storeconfigs,
  $storeconfigs_backend = $puppet::params::storeconfigs_backend
The address that the web server should bind to for HTTP requests (defaults to `localhost`.'0.0.0.0' = all).


##Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

##Limitations

This is where you list OS compatibility, version compatibility, etc.

##Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

##Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 