#!/bin/bash

### Install Docker (and deps) on OSX 


# install virtualbox, if we need to
virtualbox --help > /dev/null 2>&1
if [ $? -ne 0 ]; then
    brew install virtualbox
fi


# install vagrant, if we need to 
vagrant --help > /dev/null 2>&1
if [ $? -ne 0 ]; then

    # ensure /tmp exists
    mkdir -p /tmp
    
    # download the image
    wget -O /tmp/Vagrant-1.2.7.dmg http://files.vagrantup.com/packages/7ec0ee1d00a916f80b109a298bab08e391945243/Vagrant-1.2.7.dmg
    
    # mount the image, store the output
    drives=$(hdiutil attach /tmp/Vagrant-1.2.7.dmg)

    # install the pkg via commandline
    sudo /usr/sbin/installer -pkg /Volumes/Vagrant/Vagrant.pkg -target /

    # unmount the image 
    drive=$(echo $drives | cut -d ' ' -f 3)
    hdiutil detach $drive

fi


# clone docker to ~/src
mkdir -p ~/src
git clone https://github.com/dotcloud/docker.git ~/src/docker

# bring up the image, kickoff 
cd ~/src/docker
vagrant up
