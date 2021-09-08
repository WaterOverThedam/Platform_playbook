#!/bin/bash
h2=$(cat<<eof
java -cp /root/winning/tmts_miniservice/modules/ccp.server/public/lib/h2*.jar org.h2.tools.Shell -url jdbc:h2:tcp://${1} -user ${2} -password ${3} -sql
eof
)
sql="update SERVERMGR_HOSTCOMPUTER set USERNAME='winning',PASSWORD='x02x02x.nxiW',ISUSEPRIVATEKEY='FALSE' where OSTYPE='Linux' and code ='${4}';"
sql+="update SERVERMGR_HOSTCOMPUTER set ISUSEPRIVATEKEY=TRUE where name in ('yumplatform','cloudhost');"
$h2 "$sql"