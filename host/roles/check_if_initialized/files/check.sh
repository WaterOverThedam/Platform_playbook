#!/bin/bash

declare -a err_msg
declare -a pkg_err_msg
declare -a success_msg
status=OK
basic_pkgs=$1

java -version &>/dev/null || {
  err_msg[${#err_msg[*]}]='JDK未安装!!'
  status='unfinished'
}
if [ $status == 'OK' ];then
    success_msg[${#success_msg[*]}]='JDK已安装'
fi

java -version 2>&1|grep openjdk && {
  err_msg[${#err_msg[*]}]='JDK版本不对!!'
  status='unfinished'
}
if [ $status == 'OK' ];then
    success_msg[${#success_msg[*]}]='JDK版本正常'
fi

systemctl status agentmon  &>/dev/null || {
  err_msg[${#err_msg[*]}]='监控agentmon插件客户端未安装!!'
  status='unfinished'
}
if [ $status == 'OK' ];then
    success_msg[${#success_msg[*]}]='监控agentmon插件客户端已安装'
fi

rm -f /tmp/yum.pkg /tmp/uninstalled
rpm -qa >/tmp/yum.pkg
echo $basic_pkgs| tr "," "\n"|while read line;do
     grep "$line" /tmp/yum.pkg &>/dev/null || {
       uninstalled[${#uninstalled[*]}]=$line
       echo "${uninstalled[*]}">/tmp/uninstalled
     }
done

id winning  &>/dev/null || {
  err_msg[${#err_msg[*]}]='winning帐号未创建!!'
  status='unfinished'
}

if [ $status == 'OK' ];then
    success_msg[${#success_msg[*]}]='winning账号已创建'
fi

grep -ie '^\s*PermitRootLogin prohibit-password'  /etc/ssh/sshd_config &>/dev/null  || {
  err_msg[${#err_msg[*]}]='root帐号未做安全策略!!'
  status='unfinished'
}
if [ $status == 'OK' ];then
    success_msg[${#success_msg[*]}]='root帐号已做安全策略'
fi


grep 'ntpdate' /etc/crontab  /var/spool/cron/root &>/dev/null  || {
  err_msg[${#err_msg[*]}]='时间同步未设置!!'
  status='unfinished'
}
if [ $status == 'OK' ];then
    success_msg[${#success_msg[*]}]='时间同步已设置'
fi

getenforce|grep 'Disabled' &>/dev/null || {
  err_msg[${#err_msg[*]}]='selinux未设置!!'
  status='unfinished'
}

if [ $status == 'OK' ];then
    success_msg[${#success_msg[*]}]='selinux已设置'
fi

for msg in ${success_msg[@]}; do
     echo $msg;
done

[ -f /tmp/uninstalled ] && {
   un_rpm_list=$(cat /tmp/uninstalled)
   status='unfinished'

   echo $un_rpm_list| tr " " "\n"|while read un_rpm;do
     echo $un_rpm'未安装!!';
   done
}

if [ $status == 'unfinished' ];then
  for e in ${err_msg[@]}; do
     echo $e;
  done
  exit 1
fi

echo -n $status
