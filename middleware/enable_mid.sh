#!/bin/bash
mid_list='
consul
elasticsearch
mariadb
minio
neo4j
nginx
redis
redis1
redis2
xxl-job
keepalived
'

enable_all_mid () {
for mid in $(echo $mid_list)
do
    systemctl enable $mid > /dev/null 2>&1
done
}

Check_enabled () {
for mid in $(echo $mid_list)
do
    case $mid in
        redis*) str=redis ;;
        *) str=$mid ;;
    esac
    is_installed=$(rpm -qa | grep $str)
    if [ -z "$is_installed" ]; then
        echo -e "$mid not installed"
    else
        echo -e "  $mid - \c"
        systemctl is-enabled $mid
    fi
done
}

Help () {
echo "Usage:
  sh $0 Options

Options:
  check 检查中间件是否安装是否开机启动
  enable 将所有中间件设置为开机启动
"
}

case $1 in
    check) Check_enabled ;;
    enable) enable_all_mid ;;
    *) Help
esac
