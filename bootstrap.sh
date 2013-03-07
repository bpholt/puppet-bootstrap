#!/bin/sh

rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-6.noarch.rpm

yum install -y puppet

puppet apply bootstrap.pp
