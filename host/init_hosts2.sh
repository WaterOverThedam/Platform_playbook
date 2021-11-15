#!/bin/bash

ops=$1
ops=${ops:=localhost}
#local_ip=$(ip a | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/' |sed -nr '/[0-9]*\.[0-9]*/p')
local_ip=$(ip a | grep 'state UP' -A3 |grep 'inet'|head -1 | awk '{print $2}' |cut -f1 -d '/' |sed -nr '/[0-9]*\.[0-9]*/p')
h2=$(cat<<eof
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://${ops}//root/winning_source/h2/data/winning -user admin -password 11 -sql
eof
)
sql=$(cat<<EOF
SELECT ROOMCODE||' '||CODE||' ansible_ssh_host='''||IP_ADDR||''' ansible_ssh_port='||SSHCODE|| ' netif='''||NETCARD||''' host_id='''||h.ID||''' ansible_ssh_user='''||USERNAME||''' ansible_ssh_pass='''||PASSWORD||'''' FROM SERVERMGR_HOSTCOMPUTER h join SERVERMGR_COMPUTERGRP g on h.ID_PARENT=g.id WHERE h.OSTYPE='Linux' order by  1;
EOF
)
$h2 "$sql"|sed '/^(/d;/^\s/d' >/tmp/hosts

cat /tmp/hosts|awk '{a[$1]=a[$1]" "$2;}{str="";for(i=2;i<=NF;i++)str=str" "$i;sub(/^[ \t\r\n]+/, "", str);print str}END{for(i in a){printf "\n["i"]"gensub(" ","\n","g",a[i])}}' >hosts2

##pass decode and replace
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://${ops}//root/winning_source/h2/data/winning -user admin -password 11 -sql "SELECT PASSWORD FROM SERVERMGR_HOSTCOMPUTER h join SERVERMGR_COMPUTERGRP g on h.ID_PARENT=g.id WHERE h.OSTYPE='Linux' order by  1;" >/tmp/host_pass
cat /tmp/host_pass|sed '1d;$d'|uniq|awk '{flag=1;print "sed \x22s/"$0"/$(java -jar files/getPlaintext.jar \x27"flag"\x27 \x27"$0"\x27)/g\x22 hosts2 -i"}'|sh
exit $?