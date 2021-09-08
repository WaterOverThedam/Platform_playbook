CREATE TABLE IF NOT EXISTS `DETAIL_RECORD` (
  `PK` varchar(32) NOT NULL,
  `SPANID` bigint(20) NOT NULL,
  `DEEP_ORDER` int(11) DEFAULT NULL,
  `DETAIL_ORDER` bigint(20) NOT NULL,
  `EVENT_MSG` longtext NOT NULL,
  `EXCEPTION_MSG` longtext DEFAULT NULL,
  `EXT_MSG` longtext DEFAULT NULL,
  `MAIN_ORDER` bigint(20) NOT NULL,
  `RECORD_TYPE` varchar(20) NOT NULL,
  `START_TIME` datetime(6) NOT NULL,
  `SUCCEED` tinyint(4) DEFAULT NULL,
  `TRACEID` varchar(32) NOT NULL,
  `USE_TIME` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`PK`),
  KEY `IDX_DETAIL_RECORD_TRACEID` (`TRACEID`,`MAIN_ORDER`,`SPANID`,`DETAIL_ORDER`),
  KEY `IDX_DETAIL_RECORD_TIME` (`START_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ROOT_RECORD` (
  `PK` varchar(32) NOT NULL,
  `SPANID` bigint(20) NOT NULL,
  `APP_NAME` varchar(200) DEFAULT NULL,
  `EVENT_MSG` longtext NOT NULL,
  `EXCEPTION_MSG` longtext DEFAULT NULL,
  `MAIN_ORDER` bigint(20) NOT NULL,
  `NODEID` varchar(100) DEFAULT NULL,
  `PARAM_DATA` longtext DEFAULT NULL,
  `RECORD_TYPE` varchar(20) NOT NULL,
  `REQUEST_ADDRESS` varchar(500) DEFAULT NULL,
  `RESULT_DATA` longtext DEFAULT NULL,
  `START_TIME` datetime(6) NOT NULL,
  `SUCCEED` tinyint(4) DEFAULT NULL,
  `TRACEID` varchar(32) NOT NULL,
  `URL` varchar(512) DEFAULT NULL,
  `USE_TIME` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`PK`),
  KEY `IDX_ROOT_RECORD_TRACEID` (`TRACEID`,`MAIN_ORDER`,`SPANID`),
  KEY `IDX_ROOT_RECORD_TIME` (`START_TIME`),
  KEY `IDX_ROOT_RECORD_ACTION` (`URL`,`START_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

