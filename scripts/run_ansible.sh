#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

printf "${PURPLE}#~#~#~#~#~#~#~#~#~#~#~#~# PINGING SERVER STATUS #~#~#~#~#~#~#~#~#~#~#~#~#${NC}\n"
ansible webservers -m ping
if [[ $? != 0 ]]; then
    printf "${RED}#~#~#~#~#~#~#~#~#~# PINGING SERVER STATUS FAILED #~#~#~#~#~#~#~#~#~#${NC}\n"
    exit 2
else 
    printf "${GREEN}#~#~#~#~#~#~#~#~#~# PINGING ANSIBLE STATUS PASSED #~#~#~#~#~#~#~#~#~#${NC}\n"
fi

printf "${PURPLE}#~#~#~#~#~#~#~#~#~#~#~#~# CHECKING ANSIBLE SYNTAX #~#~#~#~#~#~#~#~#~#~#~#~#${NC}\n"
ansible-playbook manifest.yml --syntax-check
if [[ $? != 0 ]]; then
    printf "${RED}#~#~#~#~#~#~#~#~#~# CHECKING ANSIBLE SYNTAX FAILED #~#~#~#~#~#~#~#~#~#${NC}\n"
    exit 2
else 
    printf "${GREEN}#~#~#~#~#~#~#~#~#~# CHECKING ANSIBLE SYNTAX PASSED #~#~#~#~#~#~#~#~#~#${NC}\n"
fi
printf "${PURPLE}#~#~#~#~#~#~#~#~#~#~#~#~# DRY RUN #~#~#~#~#~#~#~#~#~#~#~#~#${NC}\n"
sudo ansible-playbook manifest.yml --check
if [[ $? != 0 ]]; then
    printf "${RED}#~#~#~#~#~#~#~#~#~# DRY RUN FAILED #~#~#~#~#~#~#~#~#~#${NC}\n"
    exit 2
else 
    printf "${GREEN}#~#~#~#~#~#~#~#~#~# DRY RUN PASSED #~#~#~#~#~#~#~#~#~#${NC}\n"
fi

printf "${PURPLE}#~#~#~#~#~#~#~#~#~#~#~#~# ANSIBLE RUN #~#~#~#~#~#~#~#~#~#~#~#~#${NC}\n"
sudo ansible-playbook manifest.yml
if [[ $? != 0 ]]; then
    printf "${RED}#~#~#~#~#~#~#~#~#~# ANSIBLE RUN FAILED #~#~#~#~#~#~#~#~#~#${NC}\n"
    exit 2
else 
    printf "${GREEN}#~#~#~#~#~#~#~#~#~# ANSIBLE RUN PASSED #~#~#~#~#~#~#~#~#~#${NC}\n"
fi
printf '\n%.0s' {1,2}
