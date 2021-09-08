-- drop database if EXISTS `xxl-job`;
-- CREATE database if NOT EXISTS `xxl-job` default character set utf8 collate utf8_general_ci;
use `xxl-job`;

CREATE TABLE XXL_JOB_QRTZ_JOB_DETAILS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE XXL_JOB_QRTZ_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    PRIORITY INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(200) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
        REFERENCES XXL_JOB_QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE XXL_JOB_QRTZ_SIMPLE_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(10) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES XXL_JOB_QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE XXL_JOB_QRTZ_CRON_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(200) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES XXL_JOB_QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE XXL_JOB_QRTZ_SIMPROP_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
    REFERENCES XXL_JOB_QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE XXL_JOB_QRTZ_BLOB_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES XXL_JOB_QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE XXL_JOB_QRTZ_CALENDARS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
);

CREATE TABLE XXL_JOB_QRTZ_PAUSED_TRIGGER_GRPS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_GROUP  VARCHAR(200) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
);

CREATE TABLE XXL_JOB_QRTZ_FIRED_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    SCHED_TIME BIGINT(13) NOT NULL,
    PRIORITY INTEGER NOT NULL,
    STATE VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(200) NULL,
    JOB_GROUP VARCHAR(200) NULL,
    IS_NONCONCURRENT VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,ENTRY_ID)
);

CREATE TABLE XXL_JOB_QRTZ_SCHEDULER_STATE
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
);

CREATE TABLE XXL_JOB_QRTZ_LOCKS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME  VARCHAR(40) NOT NULL,
    PRIMARY KEY (SCHED_NAME,LOCK_NAME)
);



CREATE TABLE `XXL_JOB_QRTZ_TRIGGER_INFO` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` varchar(255) NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `executor_fail_retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败重试次数',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` varchar(255) DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `XXL_JOB_QRTZ_TRIGGER_LOG` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `executor_address` varchar(255) DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_sharding_param` varchar(20) DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
  `executor_fail_retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败重试次数',
  `trigger_time` datetime DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` int(11) NOT NULL COMMENT '调度-结果',
  `trigger_msg` text COMMENT '调度-日志',
  `handle_time` datetime DEFAULT NULL COMMENT '执行-时间',
  `handle_code` int(11) NOT NULL COMMENT '执行-状态',
  `handle_msg` text COMMENT '执行-日志',
  `alarm_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
  PRIMARY KEY (`id`),
  KEY `I_trigger_time` (`trigger_time`),
  KEY `I_handle_code` (`handle_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `XXL_JOB_QRTZ_TRIGGER_LOGGLUE` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) NOT NULL COMMENT 'GLUE备注',
  `add_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE XXL_JOB_QRTZ_TRIGGER_REGISTRY (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(255) NOT NULL,
  `registry_key` varchar(255) NOT NULL,
  `registry_value` varchar(255) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `XXL_JOB_QRTZ_TRIGGER_GROUP` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(64) NOT NULL COMMENT '执行器AppName',
  `title` varchar(12) NOT NULL COMMENT '执行器名称',
  `order` tinyint(4) NOT NULL DEFAULT '0' COMMENT '排序',
  `address_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` varchar(512) DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- INSERT INTO `XXL_JOB_QRTZ_TRIGGER_GROUP`(`id`, `app_name`, `title`, `order`, `address_type`, `address_list`) VALUES (1, 'xxl-job-executor-sample', '示例执行器', 1, 0, NULL);
-- INSERT INTO `XXL_JOB_QRTZ_TRIGGER_INFO`(`id`, `job_group`, `job_cron`, `job_desc`, `add_time`, `update_time`, `author`, `alarm_email`, `executor_route_strategy`, `executor_handler`, `executor_param`, `executor_block_strategy`, `executor_timeout`, `executor_fail_retry_count`, `glue_type`, `glue_source`, `glue_remark`, `glue_updatetime`, `child_jobid`) VALUES (1, 1, '0 0 0 * * ? *', '测试任务1', '2018-11-03 22:21:31', '2018-11-03 22:21:31', 'XXL', '', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2018-11-03 22:21:31', '');

-- trigger group
INSERT INTO XXL_JOB_QRTZ_TRIGGER_GROUP
(id, app_name, title, `order`, address_type, address_list)
VALUES(2, 'winning-amts-allinone-dev', 'amts-a-prod', 1, 0, NULL);
INSERT INTO XXL_JOB_QRTZ_TRIGGER_GROUP
(id, app_name, title, `order`, address_type, address_list)
VALUES(3, 'winning-mds-allinone-dev', 'mds-a-prod', 1, 0, NULL);
INSERT INTO XXL_JOB_QRTZ_TRIGGER_GROUP
(id, app_name, title, `order`, address_type, address_list)
VALUES(4, 'winning-bmts-allinone-dev', 'bmts-a-prod', 1, 0, NULL);
INSERT INTO XXL_JOB_QRTZ_TRIGGER_GROUP
(id, app_name, title, `order`, address_type, address_list)
VALUES(5, 'xxl-job-decoupler-dev', 'decouple', 1, 0, NULL);
INSERT INTO XXL_JOB_QRTZ_TRIGGER_GROUP
(id, app_name, title, `order`, address_type, address_list)
VALUES(6, 'winning-bas-cis-outpatient-allinone-dev', 'bas-a-dev', 1, 0, NULL);
INSERT INTO XXL_JOB_QRTZ_TRIGGER_GROUP
(id, app_name, title, `order`, address_type, address_list)
VALUES(7, 'xxl-job-4131-execution-report-dev', 'ias-report', 1, 0, NULL);
INSERT INTO XXL_JOB_QRTZ_TRIGGER_GROUP
(id, app_name, title, `order`, address_type, address_list)
VALUES(8, 'winning-his-timed-task', 'HisTimed', 1, 0, NULL);
INSERT INTO XXL_JOB_QRTZ_TRIGGER_GROUP
(id, app_name, title, `order`, address_type, address_list)
VALUES(9, 'winning-ias-biz-gateway-dev', 'biz-gateway', 1, 0, NULL);

-- trigger job info

INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(2, 2, '0 30 2,12,18,22 * * ?', '药品服务同步', '2019-10-22 21:31:39.000', '2020-08-14 11:27:33.000', '临床域', '', 'ROUND', 'CsMedicineSyncHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:31:39.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(3, 2, '0 0 22 * * ?', '检验服务同步', '2019-10-22 21:32:16.000', '2020-07-25 14:10:04.000', '临床域', '', 'ROUND', 'CsLabTestSyncHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:32:16.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(4, 2, '0 30 21 * * ?', '词频同步', '2019-10-22 21:32:50.000', '2020-07-25 14:32:47.000', '临床域', '', 'ROUND', 'PrescribedCountSyncMasterData', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:32:50.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(ID, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(5, 2, '0 0 21 * * ?', '检查服务同步', '2019-10-22 21:33:24.000', '2020-07-25 14:11:11.000', '临床域', '', 'ROUND', 'CsExamSyncHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:33:24.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(6, 2, '0 30 20 * * ?', '治疗服务同步', '2019-10-22 21:33:57.000', '2020-07-25 14:11:38.000', '临床域', '', 'ROUND', 'CsTreatSyncHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:33:57.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(7, 2, '0 0 20 * * ?', '医嘱模板同步', '2019-10-22 21:34:40.000', '2020-07-25 14:12:10.000', '临床域', '', 'ROUND', 'OrderTemplateSyncHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:34:40.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(8, 3, '0 20 2,12,18,22 * * ?', '药品同步', '2019-10-22 21:36:33.000', '2020-08-14 11:27:58.000', '物品域', '', 'ROUND', 'medicationSyncRedis', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:36:33.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(9, 3, '0 55 18 * * ?', '同步术语 To Redis', '2019-10-22 21:37:05.000', '2020-07-30 16:24:11.000', '主数据', '', 'ROUND', 'Redis_Foundation_Refresh', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:37:05.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(10, 3, '0 50 18 * * ?', '同步编码规则 To Redis', '2019-10-22 21:37:41.000', '2020-07-30 16:24:15.000', '主数据', '', 'ROUND', 'Redis_Coding_Rule_Refresh', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:37:41.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(11, 3, '*/5 * * * * ?', '同步编码规则值 To Redis', '2019-10-22 21:38:14.000', '2019-11-06 21:53:30.000', 'xx', '', 'FAILOVER', 'Redis_Coding_No_Refresh', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:38:14.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(12, 3, '0 45 18 * * ?', '同步组织 To Redis', '2019-10-22 21:38:44.000', '2020-07-30 16:24:19.000', '主数据', '', 'ROUND', 'Redis_Organization_Refresh', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:38:44.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(13, 3, '0 40 18 * * ?', '员工信息同步至Redis', '2019-10-22 21:39:17.000', '2020-07-30 16:24:24.000', '主数据', '', 'ROUND', 'Redis_Employee_Refresh', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:39:17.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(14, 4, '0 */10 * * * ?', 'es同步患者信息', '2019-10-22 21:41:15.000', '2020-07-25 21:22:51.000', '患者域', '', 'ROUND', 'ssSyncPatientJob', '256181', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:41:15.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(15, 4, '0 0 1 * * ? ', '医生工作量统计', '2019-10-22 21:41:44.000', '2019-10-22 21:41:44.000', 'xx', '', 'FIRST', 'workloadStatisticsJob', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:41:44.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(16, 4, '0 0/10 * * * ?', '流向信息同步', '2019-10-22 21:42:08.000', '2019-11-06 22:28:48.000', 'xx', '', 'FIRST', 'ExecutionOrderFlowRuleSyncHandler', '256181', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:42:08.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(17, 5, '10 0/1 * * * ?', '库存同步', '2019-10-22 21:45:10.000', '2020-07-30 16:25:45.000', '物品域', '', 'ROUND', 'drugStorageSyn', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:45:10.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(19, 5, '0 0/5 * * * ?', '定时同步主数据术语', '2019-10-22 21:58:00.000', '2019-10-22 21:58:00.000', 'xx', '', 'FIRST', 'masterDataMappingSync', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-22 21:58:00.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(20, 6, '0 */30 * * * ?', 'es同步就诊信息', '2019-10-23 14:00:16.000', '2020-07-25 14:22:28.000', '就诊域', '', 'ROUND', 'esSynEncounterJob', '256181', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-23 14:00:16.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(21, 3, '0 35 19 * * ?', '诊断术语缓存作业', '2019-10-31 19:50:15.000', '2020-07-30 16:24:28.000', '记录域', '', 'FAILOVER', 'Diagnosis_ES_ValueSet_Cached_JobHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-31 19:50:15.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(22, 3, '0 30 19 * * ?', '病历术语ES缓存作业', '2019-10-31 21:32:58.000', '2020-07-30 16:23:58.000', '记录域', '', 'ROUND', 'Record_ES_ValueSet_Cached_JobHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-10-31 21:32:58.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(23, 3, '0 40 19 * * ?', '病历术语查询条件缓存作业', '2019-11-01 14:07:39.000', '2020-07-30 16:23:50.000', '记录域', '', 'ROUND', 'ValueSet_Query_Condi_Cached_JobHandler', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-11-01 14:07:39.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(24, 5, '0 5 19 * * ?', '库存全量同步', '2019-11-01 14:20:25.000', '2020-07-30 16:25:40.000', '物品域', '', 'ROUND', 'drugStorageSyn', 'syncAll', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-11-01 14:20:25.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(26, 7, '5 */5 * * * ?', '查询报告结果并写入EXE库', '2019-11-13 14:41:29.000', '2020-07-30 16:26:15.000', '执行域', '', 'ROUND', 'MedtchReportSync', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-11-13 14:41:29.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(27, 3, '0 */5 * * * ?', '刷新编码池', '2019-11-16 17:51:52.000', '2020-07-30 15:34:09.000', '主数据', '', 'ROUND', 'Redis_Code_No_Buffer_Refresh', '1500', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-11-16 17:51:52.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(28, 3, '0 25 18 * * ?', '主数据映射同步', '2019-11-27 13:28:15.000', '2020-07-30 16:23:42.000', '主数据', '', 'ROUND', 'Redis_Master_Data_Mapping_Refresh', '1', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-11-27 13:28:15.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(29, 3, '0 0 18 * * ?', '同步参数', '2019-12-03 14:33:52.000', '2020-08-03 16:59:44.000', '主数据', '', 'ROUND', 'Redis_Parameter_Refresh', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2019-12-03 14:33:52.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(30, 2, '0 0 23 * * ?', '病理服务同步', '2020-01-08 17:30:26.000', '2020-07-30 16:22:20.000', '临床域', '', 'ROUND', 'CsPathologySyncHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2020-01-08 17:30:26.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(31, 3, '0 0 6 * * ?', '同步ES诊断信息', '2020-01-13 01:11:48.000', '2020-07-30 16:23:28.000', '知识域', '', 'ROUND', 'Diagnosis_ValueSet_ES_Knowledge_JobHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2020-01-13 01:11:48.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(32, 3, '0 50 19 * * ?', '同步检验信息至ES', '2020-01-13 01:12:40.000', '2020-07-25 21:19:58.000', '知识域', '', 'FIRST', 'Knowledge_TestInfo', '256181', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2020-01-13 01:12:40.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(33, 3, '0 0 6 * * ?', '词频数据入库', '2020-04-26 22:02:38.000', '2020-07-30 16:23:22.000', '知识域', '', 'ROUND', 'Knowledge_FrequencyData', '256181,-1', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2020-04-26 22:02:38.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(34, 3, '0 5 18 * * ?', '长短码同步', '2020-05-16 12:25:15.000', '2020-07-30 16:23:16.000', '主数据', '', 'ROUND', 'Redis_One_Oid_Refresh', '', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2020-05-16 12:25:15.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(35, 2, '30 0/10 * * * ?', '同步库存', '2020-06-12 00:59:39.000', '2020-07-30 16:22:04.000', '临床域', '', 'ROUND', 'CsMedicineExecStorageSyncHandler', '256181', 'COVER_EARLY', 0, 2, 'BEAN', '', 'GLUE代码初始化', '2020-06-12 00:59:39.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(36, 3, '0 0/30 * * * ? ', '全院药品调价', '2020-06-12 16:35:36.000', '2020-06-12 16:35:36.000', '物品域', '', 'ROUND', 'hospitalMedicinePriceAdjust', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2020-06-12 16:35:36.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(41, 8, '0 */2 * * * ?', '业务失败补传 ', '2020-06-17 17:32:24.000', '2020-06-17 17:32:24.000', 'his', '', 'FIRST', 'sbbcJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2020-06-17 17:32:24.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(42, 8, '0 */2 * * * ?', '失败消息提醒 ', '2020-06-17 17:33:14.000', '2020-06-17 17:33:14.000', 'his', '', 'FIRST', 'sbxxtxJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2020-06-17 17:33:14.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(43, 8, '0 0 2 * * ?', '删除失效数据 ', '2020-06-17 17:34:02.000', '2020-06-17 17:34:02.000', 'his', '', 'FIRST', 'delsxsjJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2020-06-17 17:34:02.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(44, 8, '0 0 1 * * ?', '主数据补偿  ', '2020-06-17 17:36:58.000', '2020-07-01 09:49:45.000', 'his', '', 'FIRST', 'zsjsbbcJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2020-06-17 17:36:58.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(45, 6, '0 0 17 * * ? *', '同步诊断业务数据', '2020-06-23 20:42:11.000', '2020-06-23 21:02:32.000', '记录域', '', 'FIRST', 'Diagnosis_Sync_JobHandler', '', 'COVER_EARLY', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2020-06-23 20:42:11.000', '');
INSERT INTO XXL_JOB_QRTZ_TRIGGER_INFO
(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid)
VALUES(46, 9, '0 0/20 * * * ?', 'HIS药房库存同步', '2020-07-09 22:56:19.000', '2020-07-09 22:56:19.000', '物品域', '', 'ROUND', 'drugStorageStockSyn', '', 'COVER_EARLY', 0, 1, 'BEAN', '', 'GLUE代码初始化', '2020-07-09 22:56:19.000', '');

-- scheduler
INSERT INTO XXL_JOB_QRTZ_SCHEDULER_STATE (SCHED_NAME,INSTANCE_NAME,LAST_CHECKIN_TIME,CHECKIN_INTERVAL) VALUES
('getSchedulerFactoryBean','local.local1597721934370',1597722882403,5000);

-- locks
INSERT INTO XXL_JOB_QRTZ_LOCKS (SCHED_NAME,LOCK_NAME) VALUES
('getSchedulerFactoryBean','STATE_ACCESS')
,('getSchedulerFactoryBean','TRIGGER_ACCESS');

-- trigger detail
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','2','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','3','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','4','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','5','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','6','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','7','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','8','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','9','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','10','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','12','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','13','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','17','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','18','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','21','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','22','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','23','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','24','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','25','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','26','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','27','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','28','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','29','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','30','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','31','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','33','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','34','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','35','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','37','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','38','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','39','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','40','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','41','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','43','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
('getSchedulerFactoryBean','44','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);

-- 去除不使用的job信息
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','11','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','14','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','15','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','16','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','19','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','20','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','32','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','36','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','42','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','45','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);
-- INSERT INTO XXL_JOB_QRTZ_JOB_DETAILS (SCHED_NAME,JOB_NAME,JOB_GROUP,DESCRIPTION,JOB_CLASS_NAME,IS_DURABLE,IS_NONCONCURRENT,IS_UPDATE_DATA,REQUESTS_RECOVERY,JOB_DATA) VALUES
-- ('getSchedulerFactoryBean','46','DEFAULT',NULL,'com.xxl.job.admin.core.jobbean.RemoteHttpJobBean','0','0','0','0',null);

-- trigger
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','10','DEFAULT','10','DEFAULT',NULL,1597747800000,1597661400000,5,'WAITING','CRON',1571752719000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','12','DEFAULT','12','DEFAULT',NULL,1597747500000,1597661100000,5,'WAITING','CRON',1571752715000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','13','DEFAULT','13','DEFAULT',NULL,1597747200000,1597660800000,5,'WAITING','CRON',1571752709000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','17','DEFAULT','17','DEFAULT',NULL,1597726570000,1597726510000,5,'WAITING','CRON',1571752690000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','2','DEFAULT','2','DEFAULT',NULL,1597746600000,1597725000000,5,'WAITING','CRON',1575296607000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','21','DEFAULT','21','DEFAULT',NULL,1597750500000,1597664100000,5,'WAITING','CRON',1572522619000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','22','DEFAULT','22','DEFAULT',NULL,1597750200000,1597663800000,5,'WAITING','CRON',1572588421000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','23','DEFAULT','23','DEFAULT',NULL,1597750800000,1597664400000,5,'WAITING','CRON',1572588472000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','24','DEFAULT','24','DEFAULT',NULL,1597748700000,1597662300000,5,'WAITING','CRON',1573048367000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','26','DEFAULT','26','DEFAULT',NULL,1597726805000,1597726505000,5,'WAITING','CRON',1591084747000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','27','DEFAULT','27','DEFAULT',NULL,1597726800000,1597726500000,5,'WAITING','CRON',1573897920000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','28','DEFAULT','28','DEFAULT',NULL,1597746300000,1597659900000,5,'WAITING','CRON',1595141501000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','29','DEFAULT','29','DEFAULT',NULL,1597744800000,1597658400000,5,'WAITING','CRON',1575354947000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','3','DEFAULT','3','DEFAULT',NULL,1597759200000,1597672800000,5,'WAITING','CRON',1571752739000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','30','DEFAULT','30','DEFAULT',NULL,1597762800000,1597676400000,5,'WAITING','CRON',1588670698000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','31','DEFAULT','31','DEFAULT',NULL,1597788000000,1597701600000,5,'WAITING','CRON',1589888627000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','33','DEFAULT','33','DEFAULT',NULL,1597788000000,1597701600000,5,'WAITING','CRON',1587909764000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','34','DEFAULT','34','DEFAULT',NULL,1597745100000,1597658700000,5,'WAITING','CRON',1589603124000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','35','DEFAULT','35','DEFAULT',NULL,1597726830000,1597726230000,5,'WAITING','CRON',1591894792000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','4','DEFAULT','4','DEFAULT',NULL,1597757400000,1597671000000,5,'WAITING','CRON',1571752737000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','41','DEFAULT','41','DEFAULT',NULL,1597726560000,1597726440000,5,'ACQUIRED','CRON',1592388945000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','43','DEFAULT','43','DEFAULT',NULL,1597773600000,1597687200000,5,'WAITING','CRON',1592388949000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','44','DEFAULT','44','DEFAULT',NULL,1597770000000,1597683600000,5,'WAITING','CRON',1594349101000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','5','DEFAULT','5','DEFAULT',NULL,1597755600000,1597669200000,5,'WAITING','CRON',1571752734000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','6','DEFAULT','6','DEFAULT',NULL,1597753800000,1597667400000,5,'WAITING','CRON',1571752732000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','7','DEFAULT','7','DEFAULT',NULL,1597752000000,1597665600000,5,'WAITING','CRON',1594128765000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','8','DEFAULT','8','DEFAULT',NULL,1597746000000,1597724400000,5,'WAITING','CRON',1571752725000,0,NULL,2,'');
INSERT INTO `XXL_JOB_QRTZ_TRIGGERS` VALUES ('getSchedulerFactoryBean','9','DEFAULT','9','DEFAULT',NULL,1597748100000,1597661700000,5,'WAITING','CRON',1571752722000,0,NULL,2,'');

-- trigger cron
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','10','DEFAULT','0 50 18 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','12','DEFAULT','0 45 18 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','13','DEFAULT','0 40 18 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','17','DEFAULT','10 0/1 * * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','2','DEFAULT','0 30 2,12,18,22 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','21','DEFAULT','0 35 19 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','22','DEFAULT','0 30 19 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','23','DEFAULT','0 40 19 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','24','DEFAULT','0 5 19 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','26','DEFAULT','5 */5 * * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','27','DEFAULT','0 */5 * * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','28','DEFAULT','0 25 18 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','29','DEFAULT','0 0 18 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','3','DEFAULT','0 0 22 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','30','DEFAULT','0 0 23 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','31','DEFAULT','0 0 6 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','33','DEFAULT','0 0 6 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','34','DEFAULT','0 5 18 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','35','DEFAULT','30 0/10 * * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','4','DEFAULT','0 30 21 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','41','DEFAULT','0 */2 * * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','43','DEFAULT','0 0 2 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','44','DEFAULT','0 0 1 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','5','DEFAULT','0 0 21 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','6','DEFAULT','0 30 20 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','7','DEFAULT','0 0 20 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','8','DEFAULT','0 20 2,12,18,22 * * ?','Asia/Shanghai');
INSERT INTO `XXL_JOB_QRTZ_CRON_TRIGGERS` VALUES ('getSchedulerFactoryBean','9','DEFAULT','0 55 18 * * ?','Asia/Shanghai');

-- 更新hospital soid to_str 替换为指定医院的hospital_soit
-- UPDATE `XXL_JOB_QRTZ_TRIGGER_INFO` SET `executor_param` = replace (`executor_param`,'256181','to_str') WHERE `executor_param` LIKE '%256181%';

commit;

