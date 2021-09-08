#!/bin/bash
. ../functions.sh

ansible-playbook -i ../hosts  upgrade_app_all.yml  -t 'params,back,restart' 
