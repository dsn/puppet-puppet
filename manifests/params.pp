# == Class: puppet::params
#
# Defaults for the module
#
class puppet::params {

  # Puppet Agent Path Settings
  $confdir              = '/etc/puppet'
  $vardir               = '/var/lib/puppet'
  $logdir               = '/var/log/puppet'
  $rundir               = '/var/run/puppet'
  $ssldir               = '$vardir/ssl'

  # Service Settings
  $service_enable       = false
  $service_ensure       = stopped

  # Package Settings
  $package_ensure       = latest
  $package_name         = 'puppet'

  # Agent Configuration
  $master               = ''
  $environment          = 'production'
  $pluginsync           = true
  $report               = true
  $graph                = false
  $storeconfigs         = false
  $runinterval          = '30m'
  $reports              = 'store'
  $storeconfigs_backend = 'puppetdb'

  # Misc Variables (QOL & Lazy)
  $config_file          = "${confdir}/puppet.conf"

  # OS Specific Settings
  case $::operatingsystem {
    centos,redhat: {
      $service_name     = 'puppet'
      $sysconfig_file   = '/etc/sysconfig/puppet'
    }
    fedora: {
      $service_name     = 'puppetagent'
      $sysconfig_file   = '/etc/sysconfig/puppetagent'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

}