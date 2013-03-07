define puppet::master (
  $puppetdb_host = '',
  $puppetdb_port = '8081',
) {
  $puppetmaster = true

  package { 'puppet-server':
    ensure => present,
  }

  service { 'puppetmaster': 
    ensure     => true,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  firewall { '100 allow puppet server':
    dport  => 8140,
    proto  => tcp,
    action => accept,
  }
  
  Firewall['100 allow puppet server'] -> Service['puppetmaster']
  Package['puppet-server'] -> Service['puppetmaster']

  if $puppetdb_host {
    file { 'puppetdb-conf':
      path    => '/etc/puppet/puppetdb.conf',
      content => template('puppet/puppetdb.conf.erb'),
      owner   => root,
      group   => root,
      mode    => 0444,
    }

    file { '/etc/puppet/routes.yaml':
      source => 'puppet:///modules/puppet/routes.yaml',
      owner  => root,
      group  => root,
      mode   => 0444,
    }

    Service['puppetdb'] -> File['puppetdb-conf']
    File['puppetdb-conf'] ~> Service['puppetmaster']
    File['/etc/puppet/routes.yaml'] ~> Service['puppetmaster']
  }

  
}
