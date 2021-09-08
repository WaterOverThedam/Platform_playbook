#/bin/bash
extra_dirs=$*
get_svn=$(cat<<EOF      
svn info 2>/dev/null|awk 'BEGIN{str=""}{if (\$0~/^版本:/)str=str" "\$NF;if(\$0~/工作副本根目录:/)str=str" "\$NF;}END{print str}'
EOF
)
find /winning/app/  -name 'boot'|sort|awk -v cmd="$get_svn" '{print "cd "$0"; "cmd}'|sh|sed -r '/^$/d'
ls -ld $extra_dirs|sort|awk -v cmd="$get_svn" '{print "cd "$NF"; "cmd}'|sh|sed -r '/^$/d'
echo "有权限问题的文件数："
find  /winning/{app,log}  -user root|wc -l