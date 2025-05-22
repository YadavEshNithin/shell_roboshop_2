#!/bin/bash

source ./commons.sh

check_root


dnf module disable nginx -y &>>$LOG_FILE
VALIDATE $? "disabling nginx"

dnf module enable nginx:1.24 -y &>>$LOG_FILE
VALIDATE $? "enabling nginx"

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "installing nginx"



systemctl enable nginx  &>>$LOG_FILE
systemctl start nginx  &>>$LOG_FILE
VALIDATE $? "starting nginx"

rm -rf /usr/share/nginx/html/*  &>>$LOG_FILE
VALIDATE $? "removing default nginx content frontend"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip  &>>$LOG_FILE
VALIDATE $? "downloading  code frontend"

cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "unzipping frontend"


rm -rf /etc/nginx/nginx.confi/ &>>$LOG_FILE
VALIDATE $? "removing default nginx content"

cp $SCRIPT_DIR/nginx.config /etc/nginx/nginx.conf
VALIDATE $? "nginx config frontend added"


systemctl restart nginx  &>>$LOG_FILE
VALIDATE $? "restarting nginx frontend"


print_time