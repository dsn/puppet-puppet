# == Class: puppet::agent
#
# This is a wrapper class so we can set the runs stage appropriately.
#
# See README.md for more details on parameters.
#
class puppet::agent (
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

  validate_re($ensure, [ '^running', '^stopped', '^absent' ], "Parameter \$ensure invalid value ${ensure}\nValid Options: 'stopped|running|absent'" )

  validate_bool($enable)
  validate_bool($pluginsync)
  validate_bool($graph)
  validate_bool($report)
  validate_bool($storeconfigs)

  validate_string($master)
  validate_string($environment)
  validate_string($reports)
  validate_string($storeconfigs_backends)

  class { 'puppet::private::agent':
    ensure               => $ensure,
    enable               => $enable,
    master               => $master,
    environment          => $environment,
    pluginsync           => $pluginsync,
    runinterval          => $runinterval,
    graph                => $graph,
    report               => $report,
    reports              => $reports,
    storeconfigs         => $storeconfigs,
    storeconfigs_backend => $storeconfigs_backend,
    stage                => 'puppet'
  }
}
