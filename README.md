
Bebox sample puppet generated repo project
==========================================

This is a pre-configured bebox project that makes the provision for deploy of the [sample-rails-app-for-bebox](http://github.com/codescrum/sample-rails-app-for-bebox) example on how to use bebox.
This bebox project configures the environment to install a rails application with zero downtime deployment.

How to Use
----------

The project comes pre-configured with the most of the settings to run your own vagrant machine; but some specific settings need to be reconfigured.

###Pre-requisites

The same for bebox:
* rbenv
* ruby version >= 1.9.2 (2.1.0 recommended)
* [Vagrant](http://www.vagrantup.com/downloads.html) installed.

plus:
* [bebox](http://github.com/codescrum/bebox) installed.
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads) installed.
* [ubuntu-server-12042-x64-vbox4210-nocm.box](http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box) downloaded.

#### Bebox demo

You can see a bebox demo video for a complete example of provisioning a machine with this example code and deploying a rails application in it.

[![bebox demo video](http://img.youtube.com/vi/mioeMsuKJr4/0.jpg)](http://www.youtube.com/watch?v=mioeMsuKJr4)

###Setup

**Clone the application**

    git clone http://github.com/codescrum/bebox-sample-puppet-generated-repo

**Setup virtualbox ubuntu 12.04 box**

The project needs a pre-rolled vagrant box to run. If you did not previously configured the *ubuntu-server-12042-x64-vbox4210-nocm.box* with *bebox* you need to do the following:

    mkdir -p ~/.bebox/boxes
    ln -s BOX_PATH ~/.bebox/boxes/ubuntu-server-12042-x64-vbox4210-nocm.box

Replace BOX_PATH with the full route to the **ubuntu-server-12042-x64-vbox4210-nocm.box** file in your disk.
This creates the bebox boxes directory and a symlink to the ubuntu box in it.

**Bundle project**

Install the required gems for the project, bundle it with:

    cd bebox-sample-puppet-generated-repo
    bundle install

**Setup node**

This bebox project use one vagrant node that by default was created with the *hostname: node1.server1.test* and the *ip_address: 192.168.0.81*.

If you need to change the default *ip_address* to a free IP address in your local net, replace it in all the **node1.server1.test.yml** files in the .checkpoints directory; to do it you can run the commands:
* for linux:

        find .checkpoints/environments/vagrant -type f -exec sed -i "s/192.168.0.81/NEW_IP_ADDRESS/" {} \;

* for mac:

        find .checkpoints/environments/vagrant -type f -exec sed -i '' -e "s/192.168.0.81/NEW_IP_ADDRESS/" {} \;


Finally add to your local hosts file */etc/hosts* the line:

    IP_ADDRESS    node1.server1.test

Where IP_ADDRESS is by default *192.168.0.81* or the NEW_IP_ADDRESS if you changed in the past step.


###Execution

This commands can take a lot of time while all the libraries and programs are downloaded and setting up.

You can create, run and prepare the vagrant machine with the command:

    bebox prepare

Then you can provision the vagrant machine with:

    bebox apply --all

or one step at a time with:

    bebox apply step-N

where *N* is the step number (0, 1, 2, 3).

**
Note 1: You can access the vagrant machine with the command: *vagrant ssh* from the project directory.
**

**
Note 2: If you need the root password for the machine it is without quotes: 'bebox'
**

###Further steps

Now you can deploy the [sample-rails-app-for-bebox](http://github.com/codescrum/sample-rails-app-for-bebox) example application to the vagrant machine. Follow the instructions in its README.md file.

###Project creation

To see how this bebox project was created from the beginning you can see the git commits log.

    git log
