#!/bin/bash


h2=$(cat<<eof
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://${1} -user ${2} -password ${3} -sql
eof
)

echo $h2 "update MISMGR_CONFIG set ${7}=replace(${7},'${4}','${5}') where TYPE='appnode' AND  NODEID IN (select id from MISMGR_NODEMANAGE where NODEIP='${6}') AND ${7} LIKE '%${4}%';" >>/tmp/update_h2_$(date +%Y%m%d).log

$h2 "update MISMGR_CONFIG set ${7}=replace(${7},'${4}','${5}') where TYPE='appnode' AND NODEID IN (select id from MISMGR_NODEMANAGE where NODEIP='${6}') AND ${7} LIKE '%${4}%';" >>/tmp/update_h2_$(date +%Y%m%d).log
