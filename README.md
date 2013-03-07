Bootstrap puppet. Install puppet itself, then apply bootstrap.pp. Include in the site manifest to keep it going.

	yum install -y git
	mkdir -p /usr/share/puppet/modules
	pushd /usr/share/puppet/modules
	git clone git://github.com/bpholt/puppet-bootstrap.git puppet
	cd puppet
	sed -i '/master/d' bootstrap.pp
	./bootstrap.sh
	popd
	puppet agent --test
