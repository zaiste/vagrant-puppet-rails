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

Install [librarian-puppet](http://librarian-puppet.com/)

``` sh
λ gem install librarian-puppet
```

Clone the repository

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

Let the magic happen.
