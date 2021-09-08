#/bin/bash

ansible-playbook -i ../hosts  upgrade_app_all.yml  --skip-tags 'front'
