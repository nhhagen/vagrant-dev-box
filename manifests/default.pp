stage { 'first':
  before => Stage['main']
}

stage { 'last':
  require => Stage['main']
}

class repositories {
  include apt
  exec { 'apt-get update': command => '/usr/bin/apt-get update' } ->
  package { 'python-software-properties': ensure => present }
  apt::ppa { 'ppa:chris-lea/node.js': }
  apt::ppa { 'ppa:webupd8team/java': }
}

class tools {
  package { ['tmux', 'screen', 'wget', 'tree']:
    ensure => present
  }
}

class nodejs-modules {
  package { ['yo', 'generator-ember', 'generator-angular', 'generator-webapp',
            'nodemon']:
    ensure => present,
    provider => 'npm',
  }
}

class java {
  exec { 'accept_license':
    command => 'echo debconf shared/accepted-oracle-license-v1-1 select true \
               | sudo debconf-set-selections \
               && echo debconf shared/accepted-oracle-license-v1-1 seen true \
               | sudo debconf-set-selections',
    cwd => '/home/vagrant',
    user => 'vagrant',
    path => '/usr/bin/:/bin/',
    logoutput => true,
  } ->
  package { 'oracle-java7-installer':
    ensure => present,
  } ->
  package { 'maven':
    ensure => present
  }
}

class python {
  package { 'python':
    ensure => present
  }
}

class ruby {
  include rvm
  rvm::system_user { 'vagrant': }
  rvm_system_ruby { 'ruby-2.1':
    ensure => present,
    default_use => true
  }
  rvm_gem { ['ruby-2.1/compass', 'ruby-2.1/sass']:
    ensure => present
  }
}

# Project spesific stuff here
class project {

}

class { 'repositories':
  stage => 'first'
}

include java
include nodejs
include nodejs-modules
include ruby
include python
include tools

class { 'project':
  stage => 'last'
}

Class['repositories'] -> Class['tools']
Class['repositories'] -> Class['ruby']
Class['repositories'] -> Class['python']
Class['repositories'] -> Class['java']
Class['repositories'] -> Class['nodejs'] -> Class['nodejs-modules']
Class['repositories'] -> Class['project']

