#!/bin/bash

source ./commons.sh


check_root


dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "disabling redis"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "enabling redis"


dnf install redis -y &>>$LOG_FILE 
VALIDATE $? "installing redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "changing config for redis"

systemctl enable redis  &>>$LOG_FILE
VALIDATE $? "enabling redis"

systemctl start redis  &>>$LOG_FILE
VALIDATE $? "starting redis service"

print_time