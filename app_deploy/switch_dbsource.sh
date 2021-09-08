#/bin/bash

. ../functions.sh

main() {
    [ -z $1 ] && Echo_Red "主机名不能为空" && exit 1
    params[${#params[*]}]="replace_enable=true"
    [ ! -z $3 ] && params[${#params[*]}]="filters=$3"

    if [ -n "$2" -a "$2" = "no" ];then
       ansible-playbook -i ../hosts.ini app_restart.yml  --limit "$1" --skip-tags 'restart'  -e "${params[*]}"
    else
       ansible-playbook -i ../hosts.ini app_restart.yml  --limit "$1"  -e "${params[*]}"
    fi
    return $?
}

main $*
