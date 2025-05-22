#!/bin/bash

source ./commons.sh

check_root

echo "please enter password"
read -s "MYSQL_ROOT_PASSWORD"


dnf install mysql-server -y
VALIDATE $? "installing mysql"


systemctl enable mysqld
systemctl start mysqld
VALIDATE $? "starting mysql"



mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>$LOG_FILE
VALIDATE $? "Setting MySQL root password"


END_TIME=$(date +%s)
TOTAL_TIME=$(( $END_TIME - $START_TIME ))

print_time