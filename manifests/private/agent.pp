# == Class: puppet::private::agent
#
# This is a private class used by puppet::agent to run in Stage['puppet']
#
class puppet::private::agent (
  $ensure               = $puppet::params::service_ensure,
  $enable               = $puppet::params::service_enable,
  $master               = $puppet::params::master,
  $environment          = $puppet::params::environment,
  $pluginsync           = $puppet::params::pluginsync,
  $runinterval          = $puppet::params::runinterval,
  $graph                = $puppet::params::graph,
  $report               = $puppet::params::report,
  $reports              = $puppet::params::reports,
  $storeconfigs         = $puppet::params::storeconfigs,
  $storeconfigs_backend = $puppet::params::storeconfigs_backend
) inherits puppet {

  $libdir             = '/var/lib/puppet/lib'
  $config_file        = '/etc/puppet/puppet.conf'
  $config_template    = 'puppet.conf.erb'
  $sysconfig_template = 'sysconfig.erb'
  $package_name       = 'puppet'

  case $::operatingsystem {
    centos,redhat: {
      $service_name   = 'puppet'
      $sysconfig_file = '/etc/sysconfig/puppet'
    }
    fedora: {
      $service_name   = 'puppetagent'
      $sysconfig_file = '/etc/sysconfig/puppetagent'
    }
    default: {
      fail("Module ${name} is not supported on ${::operatingsystem}")
    }
  }

  # Check if we are running masterless
  # Make adjustments if we do not have a master defined

  package { $package_name:
    ensure => latest
  }

  case $master {
    /^$/: {

      # Remove Service Defaults
      # when running masterless
      $sysconfig_ensure = 'absent'

      # Mimic pluginsync if enabled
      if $pluginsync == true {
        file { $libdir:
          ensure  => directory,
          source  => 'puppet:///plugins',
          recurse => true,
          purge   => true,
          backup  => false,
          noop    => false,
          require => Package[$package_name]
        }
      }
    }
    default: {
      $sysconfig_ensure = 'file'
    }
  }

  # puppet.conf
  file { $config_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/${config_template}"),
    require => Package[$package_name]
  }

  # service defaults
  file { $sysconfig_file:
    ensure  => $sysconfig_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/${sysconfig_template}"),
    require => Package[$package_name]
  }

  # manage the puppet service
  service { $service_name:
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File[[$config_file],[$sysconfig_file]],
    require    => Package[$package_name]
  }
}
