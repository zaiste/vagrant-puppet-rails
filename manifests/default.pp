$home = '/home/vagrant'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

exec { "apt-update":
  command => "/usr/bin/apt-get update"
}

Exec["apt-update"] -> Package <| |>

# -

include apt


File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine for Rails development!
  Managed by Puppet."
}

stage { 'preinstall':
  before => Stage['main']
}

package { ['curl', 'build-essential', 'zlib1g-dev', 'git-core', 'libsqlite3-dev']:
  ensure => installed
} ->

package { ['python-software-properties', 'software-properties-common']:
  ensure => installed
} ->

# Nokogiri dependencies
package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
} ->

# ExecJS runtime.
package { 'nodejs':
  ensure => installed
} ->

apt::ppa { 'ppa:pitti/postgresql':
} ->
package { 'libpq-dev':
  ensure => installed
} ->
class { 'postgresql':
  charset => 'UTF8',
  version => '9.2',
} ->
class { 'postgresql::server':
  config_hash => {
    'ipv4acls' => ['local all all md5'],
  }
} ->
package { 'postgresql-contrib-9.2':
} ->
postgresql::role { 'zaiste':
  createdb => true,
  login => true,
  password_hash => postgresql_password("zaiste", "zaiste")
} ->
exec { "install_ruby_build":
  command => "git clone https://github.com/sstephenson/ruby-build.git && cd ruby-build && sudo ./install.sh",
  cwd => $home,
  creates => "/usr/local/bin/ruby-build",
  path => "/usr/bin/:/bin/",
  logoutput => true,
} ->
exec { "install_ruby":
  command => "ruby-build 2.0.0-rc2 /home/vagrant/.rubies/ruby-2.0.0-rc2",
  cwd => $home,
  creates => "/home/vagrant/.rubies/ruby-2.0.0-rc2",
  timeout => 600,
  path => "/usr/local/bin:/usr/bin/:/bin/",
  logoutput => true,
} ->
exec { "install_chruby":
  command => "wget -O chruby-0.3.4.tar.gz https://github.com/postmodern/chruby/archive/v0.3.4.tar.gz && tar -xzvf chruby-0.3.4.tar.gz && cd chruby-0.3.4/ && sudo make install",
  cwd => $home,
  creates => '/usr/local/bin/chruby-exec',
  path => "/usr/local/bin:/usr/bin/:/bin/",
  logoutput => true,
} ->
file { '/etc/profile.d/chruby.sh':
  content => '[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh'
} ->
file_line { "default_chruby":
  line => "chruby ruby-2.0.0-rc2",
  path => '/home/vagrant/.bashrc'
}