#!/bin/bash

app=$2
svn_host=$1

svn log ${svn_host}/RC/base/${app}/boot/ 2>/dev/null |awk '{if(NR==2)a=gensub(/r/,"","g",$1);if(NR==4)b=gensub(/patch_syn_([0-9]+)~([0-9]+);.*/,"\\2","g",$0)}END{print a"/"b}'|awk '/[0-9]+\/[0-9]+/'
