#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "#~#~#~#~#~#~#~#~#~#~# PINGING SERVER STATUS #~#~#~#~#~#~#~#~#~#~#"
 webservers -m ping
if [[ $? != 0 ]]; then
    printf "${RED}#~#~#~#~#~#~#~#~#~#~#${NC}PINGING SERVER STATUS FAILED${RED}#~#~#~#~#~#~#~#~#~#~#\n"
    exit 2
fi

echo "#~#~#~#~#~#~#~#~#~#~# CHECKING ANSIBLE SYNTAX #~#~#~#~#~#~#~#~#~#~#"
sudo ansible-playbook manifest.yml --syntax-check
if [[ $? != 0 ]]; then
    echo "#~#~#~#~#~#~#~#~#~#~# CHECKING ANSIBLE SYNTAX FAILED #~#~#~#~#~#~#~#~#~#~#"
    exit 2
else 
    echo "#~#~#~#~#~#~#~#~#~#~# CHECKING ANSIBLE SYNTAX PASSED #~#~#~#~#~#~#~#~#~#~#"
fi
printf '\n%.0s' {1,2}
echo "#~#~#~#~#~#~#~#~#~#~# DRY RUN #~#~#~#~#~#~#~#~#~#~#"
sudo ansible-playbook manifest.yml --check
if [[ $? != 0 ]]; then
    echo "#~#~#~#~#~#~#~#~#~#~# DRY RUN FAILED #~#~#~#~#~#~#~#~#~#~#"
    exit 2
fi

echo "#~#~#~#~#~#~#~#~#~#~# ANSIBLE RUN #~#~#~#~#~#~#~#~#~#~#"
sudo ansible-playbook manifest.yml
