#!/bin/bash

ps -ef|grep "./agent$"|awk 'NR==1{print "kill -9 "$2}'|sh &>agent.log;nohup ./agent &>>agent.log  &

if [ $(grep -v '^\s*#' /etc/rc.local|grep -c '/usr/local/agent') -eq 0 ];then
   echo 'cd /usr/local/agent/ ;nohup  ./agent  > /dev/null  2>&1  &' >>/etc/rc.local
fi
