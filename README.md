#使用之前先做好ops运管平的ssh证书免密登陆
#初始化命令调用说明

示例：
[host]
cd host
##初始化
格式：脚本名 主机编码:主机密码
./init_sys.sh cloudroomhost2:123456 cloudroomhost3:123456 cloudroomhost4:Win.2019


[middleware]
cd middleware
##安装中间件
格式：脚本名 环境编码 模块
./install_mids.sh  环境编码 模块名(all则所有模块) VIP
./install_mids.sh  prod 172.16.208.120 es
##卸载中间件
格式：脚本名 环境编码 模块
./remove_mids.sh  环境编码  模块(all则所有模块)
./remove_mids.sh  prod 172.16.208.120 es

