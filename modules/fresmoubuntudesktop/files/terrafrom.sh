#!/bin/bash

# This script was tekan from https://github.com/LevelUpEducation/terraform-tutorial
# @stefanthorpe: Thank you very much!

function terraform-install() {
  [[ -f ${HOME}/bin/terraform ]] && echo "`${HOME}/bin/terraform version` already installed at ${HOME}/bin/terraform" && return 0
  LATEST_URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | sort --version-sort | egrep -v 'rc|beta|alpha' | egrep 'linux.*amd64' |tail -1)
  curl ${LATEST_URL} > /tmp/terraform.zip
  mkdir -p ${HOME}/bin
  (cd ${HOME}/bin && unzip /tmp/terraform.zip)
  if [[ -z $(grep 'export PATH=${HOME}/bin:${PATH}' ~/.bashrc) ]]; then
  	echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc
  fi

  echo "Installed: `${HOME}/bin/terraform version`"

  cat - << EOF

Run the following to reload your PATH with terraform:
  source ~/.bashrc
EOF
}

terraform-install
