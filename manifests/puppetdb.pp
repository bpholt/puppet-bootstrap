define puppet::puppetdb (
  $host = $::fqdn,
) {

  package { 'puppetdb':
    ensure => present,
  }

  service { 'puppetdb':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  file { '/etc/puppetdb/conf.d/jetty.ini':
    ensure => present,
    owner  => 'puppetdb',
    group  => 'puppetdb',
    content => template('puppet/jetty.ini.erb'),
    mode    => 0440,
  }

  Package['puppetdb'] -> Service['puppetdb']
  File['/etc/puppetdb/conf.d/jetty.ini'] ~> Service['puppetdb']
}
