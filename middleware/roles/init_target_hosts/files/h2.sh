#!/bin/bash

h2=$(cat<<eof
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://localhost//root/winning_source/h2/data/winning -user admin -password 11 -sql 
eof
)
#echo "sql: $*"
$h2 "$*;" 2>/dev/null | awk 'NR>2{print p}{p=$0}'   
