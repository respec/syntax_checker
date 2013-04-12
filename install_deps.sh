#!/bin/bash

mkdir -p deps
cd deps

# apt-get sourced programs
which apt-get 2>&1 >/dev/null
if [ "$?" -eq "0" ]; then
    apt-get install git imagemagick tidy php5-cli ruby bash libxml2-utils wget
else
    echo "apt-get not found. Please install the following programs (you may already have them):"
    echo -e "\tgit"
    echo -e "\tnode-tar (npm)"
    echo -e "\timagemagick (identify)"
    echo -e "\ttidy"
    echo -e "\tphp5-cli (php)"
    echo -e "\truby"
    echo -e "\tbash"
    echo -e "\twget"
    echo -e "\tlibxml2-utils (xmllint)"
fi

which wget 2>&1 >/dev/null
if [ "$?" -eq "0" ]; then
    sf=$(uname -a | grep amd64; echo $?)
    if [ "$sf" -eq "0" ]; then
        wget -O node.tgz -c http://nodejs.org/dist/v0.10.4/node-v0.10.4-linux-x64.tar.gz
    else
        wget -O node.tgz -c http://nodejs.org/dist/v0.10.4/node-v0.10.4-linux-x86.tar.gz
    fi
    mkdir -p node
    tar xzf node.tgz -C node
    cd node
    mv */* .
    sudo cp -r bin lib share /usr/local/
    cd ..
else
    echo "wget not found, can't download and install node"
fi

# git sourced programs/scripts
which git 2>&1 >/dev/null
if [ "$?" -eq "0" ]; then

    if [ ! -d csslint ]; then
        git clone https://github.com/stubbornella/csslint
    else
        cd csslint
        git pull
        cd ..
    fi

    if [ ! -d pgsanity ]; then
        git clone https://github.com/markdrago/pgsanity
    else
        cd pgsanity
        git pull
        cd ..
    fi
else
    echo "Git not found!"
    echo "Can't install"
    echo -e "\tcsslint"
fi


which npm 2>&1 >/dev/null
if [ "$?" -eq "0" ]; then
    npm install -g jshint
else
    echo "npm not found!"
    echo "Can't install:"
    echo -e "\tjshint"
fi
