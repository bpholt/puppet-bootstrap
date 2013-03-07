class puppet (
  $vardir = '/var/lib/puppet',
  $puppetmaster = false,
) {

  case $operatingsystem {
    centos, redhat: {
      package { 'puppet':
        ensure => present,
      }

      file { 'puppet-conf-dir':
        path => '/etc/puppet',
        ensure => directory,
        mode => 0664,
        group => 'gpc_axiom_scm_secure',
        recurse => true,
      }

      file { 'puppet-modules':
        path => '/usr/share/puppet/modules',
        ensure => directory,
        mode => 0664,
        group => 'gpc_axiom_scm_secure',
        recurse => true,
      }

      file { 'puppet-conf':
        path   => '/etc/puppet/puppet.conf',
        ensure => present,
        mode   => 0444,
        owner  => 'root',
        group  => 'gpc_axiom_scm_secure',
        content => template('puppet/puppet.conf.erb'),
      }

      group { 'gpc_axiom_scm_secure':
        ensure => present,
      }

      Package['puppet'] -> File['puppet-conf-dir']
      Group['gpc_axiom_scm_secure'] -> File['puppet-conf-dir']
      File['puppet-conf-dir'] -> File['puppet-conf']
    }
    default: {
      notify { "Your operating system is $operatingsystem.": }
    }
  }
}


