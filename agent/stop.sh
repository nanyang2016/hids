#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname "$SCRIPT_PATH")
PROC_NAME=secu-tcs-agent

num=`ps -efw| grep "$PROC_NAME$" | grep $BASE_DIR | grep -v grep|cut -c 9-15`
for i in $num
do
		kill $i
done

num=`ps -efw| grep watchdog.sh |grep $BASE_DIR |grep -v grep|cut -c 9-15`
for i in $num
do
		kill $i
done

exit
