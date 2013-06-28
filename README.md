Vagrant & Puppet for Rails
==========================

A Vagrant configuration that automates the setup of a development environment
for Rails applications. It is based on Ubuntu 12.04 and it contains:

* PostgreSQL 9.2
* ruby-build
* chruby
* ruby-2.0.0-rc2

How to use
----------

Install [VirtualBox](https://www.virtualbox.org).

Install [Vagrant](http://vagrantup.com)

Install [Puppet](http://puppetlabs.com)

``` sh
λ gem install puppet
```
Install [librarian-puppet](http://librarian-puppet.com/)

``` sh
λ gem install librarian-puppet
```

Clone the repository you want to work with e.g.

``` sh
λ git clone https://github.com/zaiste/vagrant-puppet-rails.git
λ cd vagrant-puppet-rails
```

Initialize modules

``` sh
λ librarian-puppet install
```

Boot the virtual machine with automatic provision

``` sh
λ vagrant up
```

Start the virtual machine, install bundler, run bundle

``` sh
λ vagrant ssh
λ gem install bundler
λ cd /vagrant
λ bundle
```

Let the magic happen.
