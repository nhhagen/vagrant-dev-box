# Vagrant development box

This box is ment as a starting point for new projects. This box has been tested on OSX, it should work on Linux and it might work on Windows.

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

# Prequisites

These are things you need to install once on your machine to use this box.

1. [Virtualbox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/)
3. [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)

        vagrant plugin install vagrant-vbguest

# Starting a new project

Only one project member needs to do this.

    git clone --recursive git@github.com:nhhagen/vagrant-dev-box.git <dir>
    cd <dir>
    git remote remove origin
    git remote add origin <repo url>
    vim README.markdown # Fix the file to match your project
    git add -A .
    git commit -m "Initial project commit"
    git push

If you need to add custom tools etc in your modify `manifests/default.pp` to fit your needs.

If you have personal configuration needs or tools you need installed that are not used by the project. e.g: custom
dotfiles. Create a `~/.vagrant.d/Vagrantfile` and call provisioning to install your config/tools.

Your project might need to expose servers to the host OS (so that you can open websites in a brower etc). To forward a
port open the `Vagrantfile` a line like this:

    config.vm.network :forwarded_port, guest: <port nr>, host: <port nr>

Each project menber can now clone the new repo

    git clone --recursive <repo url>

# Starting the box

    vagrant up
    vagrant ssh
    cd /vagrant

This will place you inside the directory shared with the host OS.

# Stopping the box

    vagrant halt

This will shutdown the virtual machine.

