#/bin/bash

ip=$(ip a | grep 'state UP' -A2 |awk 'NR==3 {print $2}' | cut -f1 -d '/');
url=$1;ver=$2
pkg=${url##*/}
cd /data/svn/patch/RC/base/$pkg/
svn update
rm -rf /data/svn/patch/RC/base/$pkg/*
cd ..
svn status | grep '^!' | awk '{print $2}' | xargs svn delete
svn commit -m "delete init"
svn export $url -r $ver  ./$pkg  --username admin --password 11 --force
svn status | grep '^?' | awk '{print $2}' | xargs svn add
svn commit -m "$pkg back to version ${ver}/${3}"
