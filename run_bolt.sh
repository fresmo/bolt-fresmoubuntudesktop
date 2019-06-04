#!/bin/bash

sudo bolt apply  ~/.puppetlabs/bolt/modules/fresmoubuntudesktop/manifests/localrun.pp  --verbose  --debug  --trace -n localhost
