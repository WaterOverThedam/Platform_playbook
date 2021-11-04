#!/bin/bash

. ../../functions.sh

main() {
    [ -z $1 ] && Echo_Red "环境编码不能为空" && exit 1
    [ -z $2 ] && Echo_Red "操作类型不能为空" && exit 1
    declare -a params
    params[${#params[*]}]="group_name=$1"

    if [ "$2" == "install" ]; then
      echo ansible-playbook -i ../../$3 install.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
      ansible-playbook -i ../../$3 install.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
    elif [ "$2" == "start" ]; then
      echo ansible-playbook -i ../../$3 startup.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
      ansible-playbook -i ../../$3 startup.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
    elif [ "$2" == "restart" ]; then
      echo ansible-playbook -i ../../$3 startup.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
      ansible-playbook -i ../../$3 startup.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
    elif [ "$2" == "stop" ]; then
      echo ansible-playbook -i ../../$3 stop.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
      ansible-playbook -i ../../$3 stop.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
    elif [ "$2" == "uninstall" ]; then
      echo ansible-playbook -i ../../$3 uninstall.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
      ansible-playbook -i ../../$3 uninstall.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
    elif [ "$2" == "config" ]; then
      echo ansible-playbook -i ../../$3 config.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
      ansible-playbook -i ../../$3 config.yml -e "${params[*]} vars_file_name=$4" --limit "$1" -t "$2"
    else
      Echo_Red "操作类型【$2】非法" && exit 1
    fi

    return $?
}

main $*

