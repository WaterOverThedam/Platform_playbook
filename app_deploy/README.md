#使用之前先做好ops运管平的ssh证书免密登陆



#后端微服务批量启动操作
##restart_all.sh 环境/主机编码 过滤正则(选填，默认all)
示例：   
cd app_deploy;./restart_all.sh prod 
cd app_deploy;./restart_all.sh prod  "(10010|41920)"
cd app_deploy;./restart_all.sh prod  winning-bas-cis-outpatient-allinone
cd app_deploy;./restart_all.sh prod  10010
##stop_all.sh/start_all.sh 环境/主机编码 过滤正则(选填，默认all),同理


#加工厂切库,换医院
1. 配置dev5环境的切换关系文件 dev5_app_web1.yml
2. 切换: sh replace.sh dev5_app_web1.yml