#!/bin/bash
h2=$(cat<<eof
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://${1} -user ${2} -password ${3} -sql
eof
)
status=$5

sql="update SERVERMGR_HOSTCOMPUTER set INITFLAG=${status} where OSTYPE='Linux' and code ='${4}';"
$h2 "$sql"