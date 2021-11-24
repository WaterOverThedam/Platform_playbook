#!/bin/bash

#0.检查是否是系统是否使用了lvm分区
which lvm &>/dev/null || {
  echo '系统未使用lvm分区,不符合装机要求!!'
  exit 1
}

##/home有挂载情况处理------------------------------------------------------------ 
if [ `df -h|grep /home|wc -l` -ne 0 ]; then
    umount /home
    lvremove -y /dev/mapper/centos-home
    lvextend -l +100%FREE /dev/mapper/centos-root
    xfs_growfs /dev/mapper/centos-root
    sed -i '/\/home /d' /etc/fstab
    [ ! -d /winning ] && mkdir /winning
fi

#1.已挂载/winning则直接退出--------------------------------------------------------------
if [ `df -h|egrep '/winning$' | wc -l` -eq 1 ]; then
  echo 'winning分区已经挂载'
  exit 0
fi

#2.第二块盘存在,但不是挂载在/winning的情况处理-------------------------------------------------
disk_b=$(lsblk|awk '/db/ {print $1}'|head -1)
if [ -n "$disk_b" ];
then
mount_point=$(lsblk -o name,type,mountpoint|grep $disk_b -A 2 |grep 'lvm'|awk '{print $NF}'|grep -v lvm)
dev=$(lsblk |grep $disk_b -A 2|grep lvm |grep '└─'|awk '{print gensub("└─","/dev/mapper/","g",$1)}')
[ -n "$dev" -a "$mount_point" != "/winning" ] && {
   [[ "$mount_point" =~ '/' ]] && {
     umount $dev
     sed "/\\$mount_point/d" /etc/fstab -i
   }
   [ ! -d /winning ] && mkdir /winning
   mkfs.xfs $dev > /dev/null
   grep '/winning' /etc/fstab || echo "$dev /winning xfs defaults 0 0" >> /etc/fstab
   mount -a
   if [ `df -h|egrep '/winning$' | wc -l` -eq 1 ]; then
      echo 'winning分区挂载成功'
      exit 0
   else
      echo 'winning分区挂载失败'
      exit 1
   fi
}
fi

#3.有第二块盘及以上,但未挂载的情况. 排除第一块盘, 获取除第一块盘外的最后一块盘,第二块磁盘优先用----
array=(`lsblk|grep disk|awk '{print $1}'`)
num=`expr ${#array[@]} - 1`
for i in $(seq 0 $num)
do
  if [ `lsblk|grep -v disk|grep ${array[$i]} | wc -l` -eq 0 ]; then
     ##格式过滤是否是硬盘设备
     val=${array[i]}
     echo "$val"|egrep '[a-z]d[a-z]' && {
       disk=${array[i]}
       [[ $disk =~ 'db' ]] && break
     } 
     
  fi
done

if [ -n "$disk" ];
then
 ##防止多次执行格式化
 blkid /dev/win_vg/win_lv || {
   pvcreate /dev/$disk > /dev/null
   vgcreate win_vg /dev/$disk > /dev/null  &&
   lvcreate -y -l 100%VG -n win_lv win_vg > /dev/null &&
   mkfs.xfs /dev/win_vg/win_lv > /dev/null
 }
 ###补挂载；有分区才有挂载，避免分区表的风险
 blkid /dev/win_vg/win_lv && {
   [ ! -d /winning ] && mkdir -p /winning
   grep '/winning' /etc/fstab || echo  '/dev/win_vg/win_lv /winning xfs defaults 0 0' >> /etc/fstab
   mount -a
 }
 if [ `df -h|egrep '/winning$' | wc -l` -eq 1 ]; then
   echo 'winning分区挂载成功'
 fi

fi
ls -d /winning

