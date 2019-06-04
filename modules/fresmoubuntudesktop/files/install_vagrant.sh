#!/bin/bash

DIR='/tmp'
VER=$(curl -s https://releases.hashicorp.com/vagrant/ |grep vagrant|uniq|grep -E  -o "[0-9].[0-9].[0-9]" |sort -rn |head -n 1)

wget -q https://releases.hashicorp.com/vagrant/${VER}/vagrant_${VER}_x86_64.deb -P ${DIR}

dpkg -i ${DIR}/vagrant_${VER}_x86_64.deb
