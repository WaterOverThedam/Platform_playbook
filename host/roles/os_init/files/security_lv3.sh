#!/bin/bash
# rsyslog 远程IP地址
rsyslog_IP=172.16.6.188
# root 重命名后影响 sudo
# 密码最长过期天数
pass_max_day=90
# 密码最小过期天数
pass_min_day=80
# 密码最小长度
pass_min_len=8
# 密码过期警告天数
pass_warning=7
# 密码输错5次后被锁
lock_deny=5
# 密码输错后被锁30分钟 单位 秒
lock_time=1800
# ssh自动登出时间5分钟
auto_logout=300
# 登录用户
login_user='winning'
# 登录密码
login_pass='Win.2020'

### functions ###
Pass_Policy () {
pass_defs=/etc/login.defs
sys_auth=/etc/pam.d/system-auth
sed -i "/^PASS_MAX_DAYS/cPASS_MAX_DAYS   $pass_max_day" $pass_defs
sed -i "/^PASS_MIN_DAYS/cPASS_MIN_DAYS   $pass_min_day" $pass_defs
sed -i "/^PASS_MIN_LEN/cPASS_MIN_LEN    $pass_min_len" $pass_defs
sed -i "/^PASS_WARN_AGE/cPASS_WARN_AGE   $pass_warning" $pass_defs

sed -i "/pam_pwquality/cpassword    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type= minlen=$pass_min_len lcredit=-1 ucredit=-1 dcredit=-1 enforce_for_root" $sys_auth
}

Login_Lock () {
pam_login=/etc/pam.d/sshd
is_tally_config=$(cat $pam_login | grep pam_tally2)
if [ -z "$is_tally_config" ]; then
    sed -i "1aauth       required     pam_tally2.so deny=$lock_deny even_deny_root lock_time=$lock_time unlock_time=$lock_time\naccount    required     pam_tally2.so" $pam_login
else
    sed -i "/auth       required     pam_tally2/cauth       required     pam_tally2.so deny=$lock_deny even_deny_root lock_time=$lock_time unlock_time=$lock_time" $pam_login
    sed -i "/account    required     pam_tally2/caccount    required     pam_tally2.so" $pam_login
fi

}

Permit_Root_Login () {
sshd_config=/etc/ssh/sshd_config
is_rootlogin_config=$(cat $sshd_config | grep PermitRootLogin | grep -v setting)
if [ -z "$is_rootlogin_config" ]; then
    sed -i "/UsePAM yes/aPermitRootLogin prohibit-password" $sshd_config
else
    sed -i '/^PermitRootLogin/d' $sshd_config
    sed -i "/UsePAM yes/aPermitRootLogin prohibit-password" $sshd_config
fi
systemctl restart sshd
}

Lock_Other_Users () {
lock_users='sync halt ftp mail sshd dbus daemon adm lp operator games nobody sshd'
echo -e "locking users ...\c"
for user in $(echo $lock_users)
do
    echo -e "|$user\c"
    usermod -L $user
done
echo ''
unset user
}

Create_sys_opt_sec_Acc () {
#create_users='
#sysadmin
#sysopter
#sysaudit
#secadmin
#'
#for user in $(echo $create_users)
#do
#    useradd $user
#done
if ! id $login_user > /dev/null 2>&1 ; then
    /usr/sbin/useradd $login_user 2> /dev/null
fi
#echo "$login_user":"$login_pass" | chpasswd
is_sudoer_config=$(cat /etc/sudoers | grep '^Cmnd_Alias SHUTDOWN')
if [ -z "$is_sudoer_config" ]; then
    chmod +w /etc/sudoers
    echo '
    Cmnd_Alias SHUTDOWN=/usr/sbin/shutdown,/usr/sbin/reboot,/usr/sbin/halt,/usr/sbin/poweroff,/usr/sbin/init
    winning ALL=(ALL) NOPASSWD:ALL ,!SHUTDOWN
    winsupport ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    chmod -w /etc/sudoers
fi
}

Auto_Logout () {
sys_profile=/etc/profile
is_autologout_config=$(cat $sys_profile | grep '^TMOUT')
if [ -z "$is_autologout_config" ]; then
    sed -i "\$a\TMOUT=$auto_logout" $sys_profile
else
    sed -i '/^TMOUT/d' $sys_profile
    sed -i "\$a\TMOUT=$auto_logout" $sys_profile
fi
}

Ulimit_Config_Check () {
limits_conf=/etc/security/limits.conf
before_limits_md5=$(md5sum $limits_conf | awk '{print $1}')
noproc_conf=/etc/security/limits.d/20-nproc.conf
before_noproc_md5=$(md5sum $noproc_conf | awk '{print $1}')
conf_dir=$(dirname $limits_conf)
file1=$(basename $limits_conf)
file2=$(basename $noproc_conf)
soft_nofile_limit=800000
soft_noproc_limit=unlimited

is_limits_conf=$(cat $limits_conf | grep '^*' | grep "nofile $soft_nofile_limit ")
if [ -z "$is_limits_conf" ]; then
    # 删除*开头的行
    sed -i '/^*/d' $limits_conf
    # 删除空行
    sed -i '/^$/d' $limits_conf
    echo '
* soft nofile '$soft_nofile_limit '
* hard nofile '$soft_nofile_limit '
* soft sigpending 65535
* hard sigpending 65535' >> $limits_conf
fi

is_noproc_conf=$(cat $noproc_conf | grep '^*' | grep "$soft_noproc_limit")
if [ -z "$is_noproc_conf" ]; then
    sed -i '/^*/d' $noproc_conf
    echo "*          soft    nproc     $soft_noproc_limit" >> $noproc_conf
    echo "*          hard    nproc     $soft_noproc_limit" >> $noproc_conf
fi

after_limits_md5=$(md5sum $limits_conf | awk '{print $1}')
after_noproc_md5=$(md5sum $noproc_conf | awk '{print $1}')
if [ "$before_limits_md5" != "$after_limits_md5" -o "$before_noproc_md5" != "$after_noproc_md5" ]; then
    echo -e "\033[31m limits.conf 有改动，请重启服务器以生效!!\033[0m"
fi
}

Rsyslog_Config () {
rsyslog_conf=/etc/rsyslog.conf
echo '$ModLoad imuxsock # provides support for local system logging (e.g. via logger command)
$ModLoad imjournal # provides access to the systemd journal
$template myFormat,"%timestamp% %fromhost-ip% %msg%\n"
*.* @'$rsyslog_IP'
$WorkDirectory /var/lib/rsyslog
$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat
$IncludeConfig /etc/rsyslog.d/*.conf
$OmitLocalLogging on
$IMJournalStateFile imjournal.state
*.info;mail.none;authpriv.none;cron.none                /var/log/messages
authpriv.*                                              /var/log/secure
mail.*                                                  -/var/log/maillog
cron.*                                                  /var/log/cron
*.emerg                                                 :omusrmsg:*
uucp,news.crit                                          /var/log/spooler
local7.*                                                /var/log/boot.log' > $rsyslog_conf
# restart rsyslog server
systemctl restart rsyslog
}

## 1 密码复杂度 最少8位 要求有大写小写特殊符号 90天更换
Pass_Policy
#chage -l root

## 2 失败登录5次 锁定30分钟 重置锁定阈值30分钟
Login_Lock
# 解锁为root解锁
#pam_tally2 -r -u root

## 3 禁止root 远程登录
Permit_Root_Login

## 5 删除多余或过期账号 避免共享账户
Lock_Other_Users

## 6 创建 系统管理员 操作员 审计员 安全管理员角色 最小权限
Create_sys_opt_sec_Acc

## 7 ssh自动超时登出
Auto_Logout

## 8 系统句柄数据限制检查
Ulimit_Config_Check

# rsyslog发送到远程服务器
#Rsyslog_Config
pam_tally2 -r -u winning