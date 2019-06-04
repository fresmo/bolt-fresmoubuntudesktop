#!/bin/bash
set -x 
#set -e 

GIT_REPO="git@gitlab.com:fresmo/bolt-fresmoubuntudesktop.git"

wget -P /tmp/  https://apt.puppet.com/puppet6-release-bionic.deb
sudo dpkg -i /tmp/puppet6-release-bionic.deb
sudo apt update
sudo apt upgrade -y 
sudo apt install -y ruby puppet-bolt facter

if [ ! -d  "~/.puppetlabs/bolt/modules" ]
  then 
    mkdir -p  ~/.puppetlabs/bolt/modules
fi

if [ -d  "~/bolt_repo/bolt-fresmoubuntudesktop" ]
  then
    ln -s ~/bolt_repo/bolt-fresmoubuntudesktop/modules/fresmoubuntudesktop  ~/.puppetlabs/bolt/modules/fresmoubuntudesktop
    ln -s ~/bolt_repo/bolt-fresmoubuntudesktop/Puppetfile  ~/.puppetlabs/bolt/Puppetfile
  else
    mkdir -p ~/bolt_repo
    cd  ~/bolt_repo
    git clone $GIT_REPO
    ln -s ~/bolt_repo/bolt-fresmoubuntudesktop/modules/fresmoubuntudesktop  ~/.puppetlabs/bolt/modules/fresmoubuntudesktop
    ln -s ~/bolt_repo/bolt-fresmoubuntudesktop/Puppetfile  ~/.puppetlabs/bolt/Puppetfile
fi

bolt puppetfile install


