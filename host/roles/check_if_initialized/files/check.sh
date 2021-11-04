#!/bin/bash

declare -a err_msg
status=OK
basic_pkgs=$1

java -version &>/dev/null || {
  err_msg[${#err_msg[*]}]='JDK未安装!!'
  status='unfinished'
}

java -version 2>&1|grep openjdk && {
  err_msg[${#err_msg[*]}]='JDK版本不对!!'
  status='unfinished'
}

systemctl status agentmon  &>/dev/null || {
  err_msg[${#err_msg[*]}]='监控插件客户端未安装!!'
  status='unfinished'
}

rm -f /tmp/yum.pkg /tmp/uninstalled
rpm -qa >/tmp/yum.pkg
echo $basic_pkgs| tr "," "\n"|while read line;do
     grep "$line" /tmp/yum.pkg &>/dev/null || {
       uninstalled[${#uninstalled[*]}]=$line
       echo "${uninstalled[*]}未安装">/tmp/uninstalled
    }
done

[ -f /tmp/uninstalled ] && {
   err=$(cat /tmp/uninstalled)
   err_msg[${#err_msg[*]}]=${err// /,}
   status='unfinished'
}

id winning  &>/dev/null || {
  err_msg[${#err_msg[*]}]='winning帐号未创建!!'
  status='unfinished'
}
grep -ie '^\s*PermitRootLogin prohibit-password'  /etc/ssh/sshd_config &>/dev/null  || {
  err_msg[${#err_msg[*]}]='root帐号未做安全策略!!'
  status='unfinished'
}

grep 'ntpdate' /etc/crontab  /var/spool/cron/root &>/dev/null  || {
  err_msg[${#err_msg[*]}]='时间同步未设置!!'
  status='unfinished'
}

getenforce|grep 'Disabled' &>/dev/null || {
  err_msg[${#err_msg[*]}]='selinux未设置!!'
  status='unfinished'
}

if [ $status == 'unfinished' ];then
  for e in ${err_msg[@]}; do
     echo $e;
  done
  exit 1
fi
 
echo -n $status
#select  INITFLAG,* from servermgr_hostcomputer