class { 'puppet':
  puppetmaster => true,
}

puppet::agent {'puppet-agent': }
puppet::master {'puppet-master': }

