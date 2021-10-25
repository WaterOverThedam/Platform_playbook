#!/bin/bash

target=$(echo $1|cut -d_ -f1)
echo ansible-playbook -i ../hosts.ini  app_restart.yml --limit "$target"  -e "replace_enable=True config=${1}"  -v
ansible-playbook -i ../hosts.ini  app_restart.yml --limit "$target"  -e "replace_enable=True config=${1}"  -v
