#!/bin/bash

source ./commons.sh
app_name=dispatch

check_root

app_setup

go_setup

systemd_setup

print_time