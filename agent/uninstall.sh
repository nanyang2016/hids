#!/bin/bash

WORK_PATH=`pwd`
TMPDIR=$WORK_PATH/
# del cron monitor
CRON_FILE_TMP_1=$TMPDIR/cron.tmp.1
CRON_FILE_TMP_2=$TMPDIR/cron.tmp.2
crontab -l -u root > $CRON_FILE_TMP_1
grep -Evw 'aide|secu-tcs-agent' $CRON_FILE_TMP_1 > $CRON_FILE_TMP_2
crontab $CRON_FILE_TMP_2 -u root

echo "[OK] remove sec-agent crontab monitor ok..."

# del boot monitor
BOOT_FILE=/etc/rc.d/rc.local
BOOT_FILE_TMP=$TMPDIR/init.tmp
grep -Evw 'secu_agent' $BOOT_FILE >$BOOT_FILE_TMP
grep -Evw 'init_check' $BOOT_FILE_TMP >$BOOT_FILE
grep -Evw 'secu-tcs-agent' $BOOT_FILE >$BOOT_FILE_TMP
grep -Evw 'crontab' $BOOT_FILE_TMP >$BOOT_FILE
grep -Evw 'WORK_PATH' $BOOT_FILE >$BOOT_FILE_TMP
grep -Evw 'cron.tmp' $BOOT_FILE_TMP >$BOOT_FILE
#copyfile "$BOOT_FILE_TMP" "$BOOT_FILE" 
echo "[OK] remove sec-agent boot monitor ok..."


SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname "$SCRIPT_PATH")

PROC_NAME=secu-tcs-agent;

# kill process
ps -efw | grep "$PROC_NAME$" | grep $BASE_DIR |grep -v grep|cut -c 9-15|xargs kill 
echo "[OK] stop $PROC_NAME ok..."
#stop atd
#service atd stop
#echo "[OK] atd stop ok"
ps -efw | grep watchdog.sh | grep $BASE_DIR | grep -v grep|cut -c 9-15|xargs kill
echo "[OK] stop  watchdog ok" 
# remove file
rm -rf $BASE_DIR
echo "[OK] del sec-agent file ok..."

echo "[RESULT] sec-agent uninstall OK"

