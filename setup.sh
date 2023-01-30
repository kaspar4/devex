#!/bin/bash

SUDO_RESPONSE=$(SUDO_ASKPASS=/bin/false sudo -A whoami 2>&1)
if [[ ${SUDO_RESPONSE} == "root" ]]; then
    ANSIBLE_ASK_PASSWORD=""
elif [[ "${SUDO_RESPONSE}" == *"no password"* ]]; then
    ANSIBLE_ASK_PASSWORD="-K"
else
     echo "Unexpected sudo response: $sudo_response" >&2
     exit 1
fi

sudo apt-get install -y ansible git

ansible-galaxy collection install community.general

#sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
#sudo chmod +x /usr/local/bin/oh-my-posh

# mkdir ~/.poshthemes
# wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
# unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
# chmod u+rw ~/.poshthemes/*.omp.*
# rm ~/.poshthemes/themes.zip



# nerd fonts are 8.4GB
ansible-playbook -vv ${ANSIBLE_ASK_PASSWORD} ./laptop.yaml # -i infra/ansible/hosts
