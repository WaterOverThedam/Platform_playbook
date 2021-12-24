#!/bin/bash

sql="${*:4}"
h2=$(cat<<eof
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://${1} -user ${2} -password ${3} -sql
eof
)
sql=\"${sql//\"/\'}\"
echo $h2 ${sql//\\/}|sh
#$h2 ${sql//\\/} 2>/dev/null 

