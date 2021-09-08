#!/bin/bash

outPath=$1
prefix=$2
nodeIP=$3

h2=$(cat<<eof
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://localhost//root/winning_source/h2/data/winning -user admin -password 11 -sql 
eof
)
backend="call CSVWRITE ('${outPath}/backend.csv', 'SELECT distinct isnull((select cast(patchver as int) from mwmgr_patchsyn_log l where a.RELEASE_ID=l.RELEASEID and l.src=''syn'' order by OPERATETIME desc limit 1),0) cloud_revision,c.PROGRAM_NAME,n.appid,portnumber,n.xjport,n.deployaddr||''/''||c.PROGRAM_NAME||''/''||deployversion||''/''||portnumber destPath,''${prefix}/''||b.app_VERSION downloadUrl from MWMGR_VERSION_RELEASE a join MWMGR_APP_RELEASE b on a.RELEASE_ID=b.RELEASE_ID join MWMGR_APP c on b.APP_ID=c.ID and a.synversion is not null join MISMGR_NODEMANAGE n on n.RELEASEID=a.RELEASE_ID and n.NODEIP=''${nodeIP}'' order by n.appid')"
$h2 "$backend"

frontend="call CSVWRITE ('${outPath}/frontend.csv','SELECT distinct isnull((select cast(patchver as int) from mwmgr_patchsyn_log l where a.RELEASE_ID=l.RELEASEID and l.src=''syn'' order by OPERATETIME desc limit 1),0)cloud_revision,c.PROGRAM_NAME,deployaddr destPath,''${prefix}/''||b.app_VERSION downloadUrl from MWMGR_VERSION_RELEASE a join MWMGR_APP_RELEASE b on a.RELEASE_ID=b.RELEASE_ID join MWMGR_APP c on b.APP_ID=c.ID and a.synversion is not null join MISMGR_WEBCLIENT n on n.appid=b.app_id and n.clientip=''${nodeIP}''')"

echo  "$frontend">>/tmp/get.log

$h2 "$frontend"

sed -i 's/CLOUD_REVISION/cloud_revision/;s/DESTPATH/destPath/;s/DOWNLOADURL/downloadUrl/;s/PROGRAM_NAME/app_name/;s/APPID/appid/;s/PORTNUMBER/port/;s/XJPORT/port_xxl_job/'  ${outPath}/backend.csv  ${outPath}/frontend.csv
sed -i 's/"winning-bas-allinone-cis-outpatient"/"winning-bas-cis-outpatient-allinone"/;s/"winning-decouple-outpat"/"xxl-job-decoupler"/'  ${outPath}/backend.csv
 
exit 0;
