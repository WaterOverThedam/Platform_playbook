#!/bin/bash

source_path=/winning/winning_product/source/
[ ! -d $source_path ] && mkdir -p $source_path 

bak_file=$(find $source_path -iname '*.bak'|sort -r|awk 'NR==1')

if [ -z "$bak_file" ];then
  zip_file=$(find /winning/winning_product/ -name '*stand*.zip'|sort -r|awk 'NR==1')
  echo $zip_file
else 
  echo $bak_file
fi
