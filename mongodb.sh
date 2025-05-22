#!/bin/bash

source ./commons.sh

check_root





cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "copying repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "installing mongodb"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "enabling mongodb"

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "starting mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "changed config file for remote connections"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "restarting mongodb"

print_time