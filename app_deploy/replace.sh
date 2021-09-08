#!/bin/bash

ansible-playbook -i ../hosts.ini app_restart.yml --limit "$1:!dmts*" -e "replace_enable=True"  -v