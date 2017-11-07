#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname "$SCRIPT_PATH")

PROC_NAME="secu-tcs-agent"
MON_SAFE_SH_NAME="secu-tcs-agent-mon-safe.sh"
CHECK_LOG="$BASE_DIR/check.log"
AGENT_RESTART_SH=restart.sh
AGENT_STOP_SH=stop.sh
AGENT_CHECK_SH=check.sh
AGENT_BIN=secu-tcs-agent
AGENT_CNF=secu-tcs-agent.cnf
AGENT_SIG=secu-tcs-agent.sig
AGENT_BASE=secubase
PLUGINS_DIR=plugins
BOOT_FILE=/etc/rc.d/rc.local

CRON_OK=0
BOOT_OK=0
FILE_OK=0
PROC_OK=0
CONN_OK=0

fix_cron_mon()
{	
	CRON_FILE_TMP_1=/tmp/cron.tmp.1
	CRON_FILE_TMP_2=/tmp/cron.tmp.2
	crontab -l -u root > $CRON_FILE_TMP_1
	grep -Evw 'aide|secu-tcs-agent' $CRON_FILE_TMP_1 > $CRON_FILE_TMP_2
	echo -e "\n#secu-tcs-agent monitor, install at `date`.\n* * * * * $BASE_DIR/$MON_SAFE_SH_NAME  > /dev/null 2>&1" >> $CRON_FILE_TMP_2
	crontab $CRON_FILE_TMP_2 -u root
}

fix_boot_mon()
{
	BOOTNUM=`grep $MON_SAFE_SH_NAME $BOOT_FILE|wc -l`
	if [[ $BOOTNUM -lt 1 ]]; then
		echo -e "\n#secu-tcs-agent bootstart, install at `date`.\n$BASE_DIR/$MON_SAFE_SH_NAME > /dev/null 2>&1" >> $BOOT_FILE
	fi
}

check_onion_file()
{ 
	if [ ! -f $BASE_DIR/$MON_SAFE_SH_NAME ];then
		echo $BASE_DIR/$MON_SAFE_SH_NAME
		return 1
	fi
	if [ ! -f $BASE_DIR/$AGENT_RESTART_SH ];then
		echo $BASE_DIR/$AGENT_RESTART_SH
		return 1
	fi
	if [ ! -f $BASE_DIR/$AGENT_STOP_SH ];then
		echo $BASE_DIR/$AGENT_STOP_SH
		return 1
	fi
	if [ ! -f $BASE_DIR/$AGENT_CHECK_SH ];then
		echo $BASE_DIR/$AGENT_CHECK_SH
		return 1
	fi
	if [ ! -f $BASE_DIR/$AGENT_BIN ];then
		echo $BASE_DIR/$AGENT_BIN
		return 1
	fi
	if [ ! -f $BASE_DIR/$AGENT_BASE/$AGENT_SIG ];then
		echo $BASE_DIR/$AGENT_SIG
		return 1
	fi
	if [ ! -d $BASE_DIR/$AGENT_BASE ];then
		echo $BASE_DIR/$AGENT_BASE
		return 1
	fi
	if [ ! -d $BASE_DIR/$PLUGINS_DIR ];then
		echo $BASE_DIR/$PLUGINS_DIR
		return 1
	fi

	return 0
}


CHECK=`perl $BASE_DIR/check.pl`
if [[ $CHECK == "CONNECT CONN SERVER SUCC" ]]; then
    echo "$CHECK";
else
    echo "$CHECK\n";
    exit;
fi
# check file
check_onion_file
ret=`echo $?`
if (( $ret != 0 )); then
	echo "[RESULT] sec-agent file missed, please reinstall." |tee -a $CHECK_LOG
	exit
else
	echo "[OK] sec-agent file OK." |tee -a $CHECK_LOG
	FILE_OK=1
fi

# check crontab
CRON_MON=`crontab -uroot -l|grep "$MON_SAFE_SH_NAME"`
if [[ ! -z $CRON_MON ]];then
	echo "[OK] sec-agent cron monitor install OK." |tee -a $CHECK_LOG
	CRON_OK=1
else
	echo "[ERROR] sec-agent cron monitor not installed." |tee -a $CHECK_LOG

	echo "[INFO] Try to fix sec-agent cron monitor..." |tee -a $CHECK_LOG
	fix_cron_mon
	echo "[INFO] Fix sec-agent cron monitor OK" |tee -a $CHECK_LOG
fi

# check boot monitor
BOOTNUM=`grep $MON_SAFE_SH_NAME $BOOT_FILE|wc -l`
if [[ $BOOTNUM -ge 1 ]]; then
	echo "[OK] sec-agent boot monitor install OK." |tee -a $CHECK_LOG
	BOOT_OK=1 
else
	fix_boot_mon
fi

if (( $FILE_OK == 1 && $CRON_OK == 1  )); then
  # check process,connection
  PROC_NUM=`ps -eo pid,ppid,stime,rss,pcpu,comm|egrep "$PROC_NAME$" |wc -l`
  if (( $PROC_NUM != 0 ));then
	  echo "[OK] sec-agent agent process OK." |tee -a $CHECK_LOG
    PROC_OK=1

    NET_STATE=`netstat -nap|egrep -w "9988" |egrep ESTABLISHED|wc -l`
	  if (( $NET_STATE == 1 )); then
	    echo "[OK] sec-agent agent connection OK." |tee -a $CHECK_LOG
			CONN_OK=1
    else
	    echo "[ERROR] sec-agent agent connection NOT OK." |tee -a $CHECK_LOG
	  fi
  else
	  echo "[ERROR] sec-agent process down, please wait cron to restart" |tee -a $CHECK_LOG
  fi

 # if (( $PROC_OK == 1 && $CONN_OK == 1)); then
  if (( $PROC_OK == 1 )); then
	  echo "[RESULT] sec-agent running OK" |tee -a $CHECK_LOG
  else
	  echo "[RESULT] sec-agent running NOT OK, FIX NOT OK" |tee -a $CHECK_LOG
  fi	
else
	echo "[RESULT] sec-agent running NOT OK, FIX OK." |tee -a $CHECK_LOG
fi
