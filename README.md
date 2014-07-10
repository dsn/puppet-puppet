####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet](#setup)
    * [What puppet affects](#what-puppet-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet](#beginning-with-puppet)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module is designed to provide quick and easy management of Puppet in agent or masterless modes.

Replicate pluginsync functionality in masterless puppet.

##Module Description

The Puppet module provides a quick way to manage your Puppet Agents.

##Setup

###What puppet affects

* package/service/configuration files for Puppet
* puppet's configuration
  * **note** this will cause your puppet.conf to be overwritten (See **Usage** below for options and more information)
* service configuration files

###Setup Requirements

This module requires the Puppet Labs `stdlib` module which you can install with
```puppet module install puppetlabs-stdlib```

###Beginning with puppet

Clone this repository into your modulepath   

##Usage

### puppet::agent

The `puppet::agent` class is intended as a high-level abstraction to help simplify the process of managing your puppet agents.

####Masterless

```class { 'puppet::agent': }```

####Agent with Running Services

```class { 'puppet::agent':
     master         => 'puppet',
	 service_enable => 'true',
	 service_ensure => 'running'
   }```

####Hiera Sample
```yaml
---
classes:
  - puppet::agent

puppet::agent::master: 'puppet'
puppet::agent::service_enable: 'true'
puppet::agent::service_ensure: 'running'
```
**Parameters within `puppet::agent`:**

####`master`

The hostname or IP address of the database server. Leave empty to run in a masterless configuration.

####`environment`

The ruby / puppet environment.

* Default value: `production`

####`pluginsync`

Whether plugins should be synced with the central server. In a masterless configuration `pluginsync` can replicate the functionality as it does not exist in `puppet apply` by default.

* Default: `true`
* Valid values: `true` or `false`

####`runinterval`

How often puppet agent applies the catalog. Note that a runinterval of 0 means “run continuously” rather than “never run.” If you want puppet agent to never run, you should start it with the --no-client option. This setting can be a time interval in seconds (30 or 30s), minutes (30m), hours (6h), days (2d), or years (5y).

* Default: `30m`

####`graph`

Whether to create dot graph files for the different configuration graphs. These dot files can be interpreted by tools like OmniGraffle or dot (which is part of ImageMagick).

* Default: `false`
* Valid values: `true` or `false`

####`report`

Whether to send reports after every transaction.

* Default: `true`
* Valid values: `true` or `false`

####`reports`

The list of report handlers to use. When using multiple report handlers, their names should be comma-separated, with whitespace allowed. (For example, reports = http, tagmail.)

* Default: `store`

####`storeconfigs`

Whether to store each client’s configuration, including catalogs, facts, and related data. This also enables the import and export of resources in the Puppet language - a mechanism for exchange resources between nodes.

* Default: `false`
* Valid values: `true` or `false`

####`storeconfigs_backend`

Configure the backend terminus used for StoreConfigs.

* Default value: `puppetdb`

####`service_ensure`

Whether the Puppet Agent service should be running.

* Default value: `stopped`
* Valid values: `stoppped` or `running`

####`service_enable`

Whether a service should be enabled to start at boot.

* Default value: `false`
* Valid value: `true` or `false`

####`package_ensure`
What state the package should be in.

* Default value: present
* Valid values: `present` or `latest`

####`package_name`

The package name. Could vary by operating systems

Default value: puppet

##Limitations

Does not manage routes.yaml, hiera.yaml, or puppetdb.conf

Currently Puppet is compatible with

```Puppet Version: 2.7+```

Platforms:
* CentOS 6
* Fedora 18
* RHEL 6

##Development

Rake tasks have been created to assist in testing your module during development. To run the unit tests you might have to install some ruby gems.

```cd /path/to/puppet && bundle install```

Tasks:

* test - Run a battery of tests against your module
* spec - Run Unit Tests (RSpec)
* lint - Check Puppet Manifest Style
* syntax - Check Puppet Manifests Syntax
* 