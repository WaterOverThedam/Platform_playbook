/bin/bash

h2=$(cat<<eof
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://${1} -user ${2} -password ${3} -sql
eof
)

$h2 "select value from sys_param where code ='${4}';" 2>/dev/null|grep -A 1 ^VALUE|grep -v VALUE