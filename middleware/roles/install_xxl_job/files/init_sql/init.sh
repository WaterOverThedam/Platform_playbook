sed "s/256181/$1/" ./xxl_job.sql >xxl_job_tmp.sql

mysql -uwinning -pMaria@win60.DB  < ./recreate_db.sql
mysql -uwinning -pMaria@win60.DB  win_log < ./win_log.sql
mysql -uwinning -pMaria@win60.DB  xxl-job < ./xxl_job_tmp.sql
