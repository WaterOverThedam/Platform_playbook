#!/bin/bash


svn_url=$1
cloud_revision=$2
echo $svn_url >/tmp/debug.log 
echo svn log $svn_url 2>/dev/null |grep -B 2 "patch_syn_${cloud_revision}~${cloud_revision};"|awk 'NR==1{print gensub("r","","g",$1)}'|awk '/[0-9]+/'>>/root/debug.log
svn log $svn_url 2>/dev/null |grep -B 2 "patch_syn_${cloud_revision}~${cloud_revision};"|awk 'NR==1{print gensub("r","","g",$1)}'|awk '/[0-9]+/'
