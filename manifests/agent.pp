define puppet::agent {

  host { 'puppet.local':
    ip => '166.78.126.53',
  }

  service { 'puppet': 
    ensure     => true,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
  
  Host['puppet.local'] -> Service['puppet']
 
}
