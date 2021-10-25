#!/bin/bash

if [ `df -h|grep /home|wc -l` -ne 0 ]; then
    umount /home
    lvremove -y /dev/mapper/centos-home
    lvextend -l +100%FREE /dev/mapper/centos-root
    xfs_growfs /dev/mapper/centos-root
    sed -i '/\/home /d' /etc/fstab
    mkdir /winning
    mount -a
fi