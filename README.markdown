# Vagrant development box

This box is a starting point for new projects. This box has been tested on OSX, it should work on Linux and it might work on Windows.

## Prerequisites

These are things you need to install once on your machine to use this box.

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](http://www.vagrantup.com/)
* [Python](https://www.python.org/), to run the new project setup script.

Then run:

```bash
vagrant plugin install vagrant-vbguest
```

## Starting a new project

To start a new project run:

```bash
python setup.py --directory <project-directory> [--remote <new repo url>]
```

Only one project member needs to do this.

If you have personal configuration needs or tools you need installed that are not used by the project. e.g: custom
dotfiles. Create a `~/.vagrant.d/Vagrantfile` and call provisioning to install your config/tools.

Your project might need to expose servers to the host OS (so that you can open websites in a brower etc). To forward a
port open the `./Vagrantfile` a line like this:

```ruby
config.vm.network :forwarded_port, guest: <port nr>, host: <port nr>
```

Each project menber can now clone the new repo

```bash
git clone <repo url>
```

## Starting the box

```bash
vagrant up dev
vagrant ssh dev
cd /vagrant
```

This will place you inside the directory shared with the host OS.

## Stopping the box

```bash
vagrant halt dev
```

This will shutdown the virtual machine.

## Software

[SaltStack](http://www.saltstack.com/community/) is used to install software to change what is installed have a look at the
[documentation](http://docs.saltstack.com/). For a quicker provisioning process you should remove software that you do
not need in your project.

The main file to include or exclude software is `./salt/roots/salt/top.sls`.

After adding new software to the saltstack configuration run:

```bash
vagrant provision
```

# Test environment on Azure

You need to create certificates before you can start and stop the test
environment.

## Manage certificates

Generate keys

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout .azure/myPrivateKey.key -out .azure/myCert.pem
chmod 600 .azure/myPrivateKey.key
openssl x509 -outform der -in .azure/myCert.pem -out .azure/myCert.cer
```

Combine `.azure/myCert.pem` and `.azure/myPrivateKey.key` and transform into
`.azure/myCertPfx.pem`.

```bash
openssl pkcs12 -export -in .azure/myCert.pem -inkey .azure/myPrivateKey.key -out .azure/myCert.pfx
openssl pkcs12 -in .azure/myCert.pfx -out .azure/myCertPfx.pem -nodes
```

Upload `.azure/myCert.cer` to
[https://manage.windowsazure.com/#Workspace/AdminTasks/ListManagementCertificates](https://manage.windowsazure.com/#Workspace/AdminTasks/ListManagementCertificates).
`.azure/myCertPfx.pem` and `.azure\myPrivateKey.key` are used in the
`Vagrantfile`.

The `.azure` should be shared by all project members.

## Edit `./Vagrantfile`

Set your password to the box and your subscription_id
```ruby
password = '#########' # min 8 characters. should contain a lower case letter, an uppercase letter, a number and a special character
azure.subscription_id = '####################################'
```

## Starting the box

```bash
vagrant up azure --provider=azure
vagrant ssh azure
cd /vagrant
```

This will place you inside the directory shared with the host OS.

## Stopping the box

```bash
vagrant halt azure
```
