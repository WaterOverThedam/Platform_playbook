#!/bin/bash

APP_DEPLOY_PATH=(`pwd`)

## 监测服务
check()
{
    spid=`ps aux | grep -v grep | grep $APP_DEPLOY_PATH | awk 'NR==1{print $2}'`
    if [ ! $spid ];then
        # stopped
        return 1;
    else
        # running
        return 0;
    fi
}

## 强制终止
fstop()
{
    check
    if (($? == 1));then
        echo "【$APP_DEPLOY_PATH】 service has been stopped!!!"
    else
        spid=`ps aux | grep -v grep | grep $APP_DEPLOY_PATH | awk 'NR==1{print $2}'`
        echo -n "【$APP_DEPLOY_PATH】 service pid:$spid force to stop ..."

        kill -9 $spid

        retry_time=5
        while ((retry_time>0))
        do
            check
            if (($? == 1));then
                echo -e '\033[32mstopped\033[1m\033[0m'
                break
            else
                echo -n '.'
                sleep 1
            fi
            ((retry_time=retry_time-1))
        done
    fi
}

## 终止
stop()
{
    check
    if (($? == 1));then
        echo "【$APP_DEPLOY_PATH】 service has been stopped!!!"
    else

        spid=`ps aux | grep -v grep | grep $APP_DEPLOY_PATH | awk 'NR==1{print $2}'`
        echo -n "【$APP_DEPLOY_PATH】 pid:$spid service to stop..."

        kill -15 $spid
        ## 重试10次
        retry_time=10
        while true
        do
            if ((retry_time == 0));then
                echo
                fstop
                break
            fi
            check
            if (($? == 1));then
                echo -e '\033[32mstopped\033[1m\033[0m'
                break
            else
                #((retry_time=retry_time-1))
                echo -n '.'
                sleep 1s
            fi
            ((retry_time=retry_time-1))
        done
    fi
}

stop
