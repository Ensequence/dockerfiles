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


# do we need the latest go?
correctgo=$(go version | cut -d ' ' -f 3 | grep go1.1.1 | wc -l)
if [ "$correctgo" -ne "1" ]; then

    # remove old go (just in case)
    sudo rm -r /usr/local/go

    # download latest go 
    wget -O /tmp/go1.1.1.darwin-386.pkg https://go.googlecode.com/files/go1.1.1.darwin-386.pkg
    sudo /usr/sbin/installer -pkg /tmp/go1.1.1.darwin-386.pkg -target /
fi


# clone docker to ~/src
if [ ! -d ~/src/docker ]; then
    mkdir -p ~/src
    git clone https://github.com/dotcloud/docker.git ~/src/docker    
fi

# build docker
docker version > /dev/null 2>&1
if [ $? -ne 0 ]; then
    cd ~/src/docker
    # we need to build for the Mac against v0.5.0
    git checkout v0.5.0
    make clean all VERBOSE=1
    sudo mv ./bin/docker /usr/bin/docker
    # once we're done, move back to master
    git checkout master
fi


# bring up the image, kickoff 
cd ~/src/docker
GREEN="\033[0;32m"
startvagrant=$(vagrant status | head -n 3 | tail -n 1 | grep running | wc -l)
if [ "$startvagrant" -ne "1" ]; then
    vagrant up
    echo -en "$GREEN If you need to \`vagrant reload\`, please \`cd ~/src\` first."
else 
    echo -en "$GREEN Try using \`docker version\` to use see if you can use Docker from the Mac \n"
fi


# 
