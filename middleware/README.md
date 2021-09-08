# 2.中间件安装
## 2.1.说明
Ansible部署中间件模块

## 2.2.前提条件
* 主机初始化完成
* 中间件yum源正常

## 2.3.执行流程
1. 设置`hosts.ini`文件中主机信息,hosts主机名命名以`mid`开头

## 2.4.执行实例
中间件有:consul,es,keeplived,minio,neo4j,rabbitmq,redis,nginx,mariadb,xxljob

执行格式：`./install_mids.sh  环境编码 模块名(all则所有模块) [VIP]`

### 2.4.1.部署中间件
```shell
## 部署全部中间件
./install_mids.sh all

## 部署consul
./install_mids.sh consul

## 部署es
./install_mids.sh es

## 部署keeplived
./install_mids.sh keeplived

## 部署minio
./install_mids.sh minio

## 部署neo4j
./install_mids.sh neo4j

## 部署rabbitmq
./install_mids.sh rabbitmq

## 部署redis
./install_mids.sh redis

## 部署nginx
./install_mids.sh nginx

## 部署mariadb
./install_mids.sh mariadb

## 部署xxljob
./install_mids.sh xxljob
```

### 2.4.2.卸载中间件
执行格式：`./remove_mids.sh 环境组编码或主机编码(列表用逗号间隔) 中间件模块名(all则表示所有模块;列表用逗号间隔)`
```shell
#### 卸载prod环境组下主机的所有中间件
./remove_mids.sh prod all
#### 卸载prod环境组下主机的redis
./remove_mids.sh prod redis
#### 卸载mid1主机的所有中间件
./remove_mids.sh mid1 all
#### 卸载mid1和mid2主机的redis和neo4j
./remove_mids.sh mid1,mid2 neo4j,minio
```
### 2.4.3.重启中间件
执行格式：`./restart_mids.sh 环境组编码或主机编码(列表用逗号间隔) 中间件模块名(all则表示所有模块;列表用逗号间隔)`
```shell
#### 重启prod环境组下主机的所有中间件
./restart_mids.sh prod all
#### 重启prod环境组下主机的redis
./restart_mids.sh prod redis
#### 重启mid1主机的所有中间件
./restart_mids.sh mid1 all
#### 重启mid1和mid2主机的redis和neo4j
./restart_mids.sh mid1,mid2 neo4j,minio
```
### 2.4.4.停止中间件
执行格式：`./stop_mids.sh 环境组编码或主机编码(列表用逗号间隔) 中间件模块名(all则表示所有模块;列表用逗号间隔)`
```shell
#### 停止prod环境组下主机的所有中间件
./stop_mids.sh prod all
#### 停止prod环境组下主机的redis
./stop_mids.sh prod redis
#### 停止mid1主机的所有中间件
./stop_mids.sh mid1 all
#### 停止mid1和mid2主机的redis和neo4j
./stop_mids.sh mid1,mid2 neo4j,minio
```
### 2.4.5.启动中间件
执行格式：`./start_mids.sh 环境组编码或主机编码(列表用逗号间隔) 中间件模块名(all则表示所有模块;列表用逗号间隔)`
```shell
#### 启动prod环境组下主机的所有中间件
./start_mids.sh prod all
#### 启动prod环境组下主机的redis
./start_mids.sh prod redis
#### 启动mid1主机的所有中间件
./start_mids.sh mid1 all
#### 启动mid1和mid2主机的redis和neo4j
./start_mids.sh mid1,mid2 neo4j,minio
```