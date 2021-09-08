#!/bin/bash


echo "------【check redis】------"
if [ ! -z $1 -a $1 -gt 1 ];then
  redis-cli -c -p 6381 -a 'winning.2019' --no-auth-warning  set k1 v1 && redis-cli -c -p 6381 -a 'winning.2019' --no-auth-warning get k1
  redis-cli --cluster check $2  6381 -a 'winning.2019' --no-auth-warning
  echo "【redis压测】合格范围3万-20万，越高越好！"
  redis-benchmark -p 6381 -c 1000 -n 100000 -q -t set,get,hset,lpush,mset
else 
  echo "【redis压测】合格范围3万-20万，越高越好！"
  redis-cli -p 6379 -a 'winning.2019' --no-auth-warning  set k1 v1 && redis-cli -p 6379 -a 'winning.2019' --no-auth-warning get k1
  redis-benchmark -p 6379 -c 1000 -n 100000 -q -t set,get,hset,lpush,mset
fi 

echo "-----【check consul】------"
  consul operator raft list-peers
  wget  -O - localhost:8500/v1/catalog/services|python -mjson.tool
echo "----【check rabbitmq】-----"
  rabbitmqctl cluster_status
  rabbitmqctl list_users
  rabbitmqctl list_policies
echo "----【check elsticsearch】-----"
  curl 127.0.0.1:19200/_cat/nodes?v 
  curl http://127.0.0.1:19200/_cluster/settings?pretty
  #curl http://127.0.0.1:19200/cli_search_medicine/_settings?pretty
  #curl http://127.0.0.1:19200/cli_search_cs_all/_settings?pretty
echo "------【check minio】------"
  mc config host add minio http://127.0.0.1:9000 www.winning.com.cn www.winning.com.cn --api s3v4
  mc ls minio
echo "------【check mysql】------"
  mysql -uwinning -pMaria@win60.DB  win_log  -e 'show tables;'
  mysql -uwinning -pMaria@win60.DB  xxl-job  -e 'show tables;'

