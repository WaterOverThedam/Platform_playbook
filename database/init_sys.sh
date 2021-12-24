#!/bin/bash

. ./functions.sh

main() {

    #parse parameters
    declare -A dict
    declare -a hosts
    for p in $*; do
        pos=$(strindex $p ':')
        if [ $pos -ne -1 -a $(($pos+1)) -eq ${#p} ]; then
            Echo_Red "password can't be empty!"
            exit 1
        else
            arr=(${p/:/ })
            key=${arr[0]}
            val=${arr[1]}
            dict[$key]=$val
            hosts[${#hosts[*]}]=$key
        fi
    done


    #Generate invetory
    #./init_hosts.sh

    [ -f ../hosts.ini ] || {
        Echo_Red "找不到主机清单！"
        exit 1
    }

    hosts=${hosts[*]}
    #Enable ansible surpport for password login
    sed -ir '/host_key_checking/s/^\s*#//' /etc/ansible/ansible.cfg

    if [ ! -z "$res" ]; then
        Echo_Red "$res"
        exit 1
    fi

    #Add password info only when host.ini do not contains these infos
   if grep -q 'ansible_ssh_pass' ../hosts.ini
    then
      sed -r -i.bak "s/ansible_ssh_pass=\S*'\B//" ../hosts.ini 
    else
      tmp=${dict[*]}
      tmp=${tmp// /}
      [ -z "$tmp" ] && {
        Echo_Red "password is not set!"
        exit 1
      }
      cat ../hosts.ini | awk '{if (!/ansible_ssh_host/) {print $0 }else {print $0" ansible_ssh_pass=pwd."$1}}' > ../hosts.ini.bak
      for i in ${!dict[@]}; do
          #echo $i,${dict[$i]}
          sed "s#pwd.$i#${dict[$i]}#" -i ../hosts.ini.bak
      done
   fi

    #Check config if it is corrent
    res=$(cat ../hosts.ini | sed -n '/\[/,$!p' | awk '!/^\s*$/ {print $1,$(NF)}' | awk -v "hosts=$hosts" '!/root''/ && index(hosts,$1)>0 {print "主机"$1" 不是使用root帐户！请配置root帐号做初始化操作！"}')
    #Batch copy ssh key
    echo  ansible "${hosts// /,}" -i ../hosts.ini.bak -m authorized_key -a 'user=root key="{{ lookup("file", "/root/.ssh/id_rsa.pub")}}"'
    ansible "${hosts// /,}" -i ../hosts.ini.bak -m authorized_key -a 'user=root key="{{ lookup("file", "/root/.ssh/id_rsa.pub")}}"'

    #Begin init linux hosts
    if [ -z "$hosts" ]; then
        Echo_Red "请选择需要初始化的主机"
    elif [ "$(echo $hosts | tr -t '[a-z]' '[A-Z]')" == "ALL" ]; then
        ansible-playbook -i ../hosts.ini init_sys.yml
    else
        ansible-playbook -i ../hosts.ini init_sys.yml --limit "${hosts// /,}"
    fi

    mv ../hosts.ini.bak hosts.ini.bak_$(date +%Y%m%d) && expect ./encrypt_host.exp Wy666513% $_

    return 0

}

main $*
