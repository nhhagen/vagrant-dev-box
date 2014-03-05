# Vagrant development box

This box is a starting point for new projects. This box has been tested on OSX, it should work on Linux and it might work on Windows.

## Prerequisites

These are things you need to install once on your machine to use this box.

1. [Virtualbox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/)
3. [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)

        vagrant plugin install vagrant-vbguest

# Starting a new project

To start a new project run:

```bash
curl https://raw.github.com/nhhagen/vagrant-dev-box/master/setup.sh | bash -s <new repo url> <dir>
```

Only one project member needs to do this.

If you want a simple command at hand to start new projects off this box run:

__#!/bin/bash__

```bash
echo "function newproject { curl https://raw.github.com/nhhagen/vagrant-dev-box/master/setup.sh | bash -s $@ ; }" >> ~/.bash_profile && source ~/.bash_profile
```

You can now run:

```bash
newproject <new repo url> <div>
```

[SaltStack](http://www.saltstack.com/community/) is used to install software to change what is installed have a look at the
[documentation](http://docs.saltstack.com/). For a quicker provisioning process you should remove software that you do
not need in your project.

If you have personal configuration needs or tools you need installed that are not used by the project. e.g: custom
dotfiles. Create a `~/.vagrant.d/Vagrantfile` and call provisioning to install your config/tools.

Your project might need to expose servers to the host OS (so that you can open websites in a brower etc). To forward a
port open the `Vagrantfile` a line like this:

```ruby
config.vm.network :forwarded_port, guest: <port nr>, host: <port nr>
```

Each project menber can now clone the new repo

```bash
git clone --recursive <repo url>
```

# Starting the box

```bash
vagrant up
vagrant ssh
cd /vagrant
```

This will place you inside the directory shared with the host OS.

# Stopping the box

```bash
vagrant halt
```

This will shutdown the virtual machine.

## Programming environments

* node
* ruby (2.1)
* python (2.7)
* java (7)

## Tools

* yo
    * generator-angular
    * generator-ember
    * generator-webapp
* grunt
* bower
* compass
* sass
* maven
* tmux
* screen
* curl
* wget

