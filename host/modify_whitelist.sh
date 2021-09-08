#!/bin/bash

. ./functions.sh

main() {
    [ -z $1 ] && Echo_Red "环境编码不能为空" && exit 1
    [ -z $2 ] && Echo_Red "IP白名单不能为空" && exit 1
    white_list=$(echo $2|awk '/[\.\d]*[,]?/')
    [ -z $2 ] && Echo_Red "IP白名单参数格式不对！请传ip地址，多个ip逗号间隔！" && exit 1
    type=$3
    type=${type:='add'}

    if [ $type = "add" ]; then
        echo ansible-playbook -i ../hosts.ini modify_whitelist.yml -e "white_list=$2"  --limit "$1"
        ansible-playbook -i hosts modify_whitelist.yml -e "white_list=$2"  --limit "$1"
    elif [ $type = 'remove' ]; then
        echo ansible-playbook -i ../hosts.ini modify_whitelist.yml --skip-tags "add" -e "white_list=$2"  --limit "$1"
        ansible-playbook -i hosts modify_whitelist.yml --skip-tags "add" -e "white_list=$2"  --limit "$1"
    elif [ $type = 'reset' ]; then
        echo ansible-playbook -i ../hosts.ini init_sys.yml -t "params,firewall" -e "extra_ips=$2"  --limit "$1"
        ansible-playbook -i ../hosts.ini init_sys.yml -t "params,firewall" -e "extra_ips=$2"  --limit "$1"
    fi

    return $?
}

main $*
