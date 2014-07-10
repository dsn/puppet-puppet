# == Class: puppet
#
# Base class for managing Puppet.
# DO NOT CALL THIS CLASS DIRECTLY.
#
# See README.md for more details on parameters.
#
class puppet (
  $confdir = $puppet::params::confdir,
  $vardir  = $puppet::params::vardir,
  $logdir  = $puppet::params::logdir,
  $rundir  = $puppet::params::rundir,
  $ssldir  = $puppet::params::ssldir
) inherits puppet::params {

  # Ensure only RedHat OS Family is Supported
  case $::osfamily {
    RedHat: {
      $package_name = 'puppet'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  # Prepare our Run Stage
  stage { 'puppet':
    before => Stage['main']
  }

}