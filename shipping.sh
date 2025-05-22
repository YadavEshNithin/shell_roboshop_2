#!/bin/bash

source ./commons.sh
app_name=shipping


check_root

echo "please enter password"
read -s "MYSQL_ROOT_PASSWORD"


app_setup 


maven_setup

systemd_setup 


dnf install mysql -y
VALIDATE $? "installing mysql for shipping" 


mysql -h mysql.rshopdaws84s.site -u root -p$MYSQL_ROOT_PASSWORD -e 'use cities' &>>$LOG_FILE
if [ $? -ne 0 ]
then
    mysql -h mysql.rshopdaws84s.site -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/schema.sql &>>$LOG_FILE
    mysql -h mysql.rshopdaws84s.site -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/app-user.sql  &>>$LOG_FILE
    mysql -h mysql.rshopdaws84s.site -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/master-data.sql &>>$LOG_FILE
    VALIDATE $? "Loading data into MySQL"
else
    echo -e "Data is already loaded into MySQL ... $Y SKIPPING $N"
fi 



systemctl restart shipping &>>$LOG_FILE
VALIDATE $? "Restart shipping"

print_time











