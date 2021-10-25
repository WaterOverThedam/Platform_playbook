#!/bin/bash

mc config host add minio http://127.0.0.1:9000 www.winning.com.cn www.winning.com.cn --api s3v4
mc mb minio/emr
mc mb minio/finance
mc mb minio/mdm
mc mb minio/cooperation
mc mb minio/encounter

mc  policy  set  public  minio/emr
mc  policy  set  public  minio/finance
mc  policy  set  public  minio/cooperation
mc  policy  set  public  minio/mdm
mc  policy  set  public  minio/encounter
