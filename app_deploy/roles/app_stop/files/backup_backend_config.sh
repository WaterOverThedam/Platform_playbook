#!/bin/bash

[ -z "$1" ] && echo "原环境名称不能为空" && exit 1

config_dir="/winning/config_bak/$1"

if [ ! -d "$config_dir" ];then
  mkdir -p $config_dir && cd $_
  find  /winning/app/win* -name application.properties|awk -F "/" '{print "cp "$0" "$4"_application.properties"}'|sh
fi