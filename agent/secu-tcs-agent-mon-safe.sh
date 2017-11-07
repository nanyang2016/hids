#!/bin/bash
###ver=5.0.0

echo $PATH>/tmp/.PATH
PATH="/usr/local/bin:/usr/bin:/sbin:/usr/X11R6/bin:/usr/sbin:/bin:/usr/games"
export PATH

CRON_FILE_TMP_1=$TMPDIR/cron.tmp.1
CRON_FILE_TMP_2=$TMPDIR/cron.tmp.2			

# 5%
CPU_LIMIT=500
# uint: KB, 50M
RSS_LIMIT=51200

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname "$SCRIPT_PATH")

PROC_NAME=secu-tcs-agent

TMPDIR=/tmp
TMP=$BASE_DIR/secu_monitor.tmp

PS_INFO=$BASE_DIR/secubase/secu-tcs-ps.info
MON_LOG=$BASE_DIR/secubase/secu-tcs-ps.log
LIMIT_FILE=$BASE_DIR/secubase/secu-tcs-ps.lmt

function DoLog()
{
	CUR_TIME=`date +"%Y-%m-%d %H:%M:%S"`;
	echo "[$CUR_TIME] $1" >> $MON_LOG;
}

if [ -e $TMP ]
then
	find $TMP -amin +30|xargs rm -rf
fi

if [ -e $TMP ]
then
	echo "there are running shell - $MON_SAFE_SH..."
	exit
fi

# 检查日志, 如果大小超过限制就删除
if [ -e ${MON_LOG} ];then
	LOG_FILE_SIZE=`stat --format=%s ${MON_LOG}`;
	# limit 10K
	if [[  $LOG_FILE_SIZE -gt 10240 ]];then
		rm ${MON_LOG}
	fi
fi

# 启动watchdog
WATCH_DOG=`ps -efw | grep  watchdog.sh | grep $BASE_DIR | grep -v grep |wc -l`
if [  $WATCH_DOG -lt 1 ];then
	DoLog "WARNING: watchdog.sh restarted because of process has down!!! watchdog_num: $WATCH_DOG;";
	$BASE_DIR/watchdog.sh &
fi


# 判断agent是否成功启动，如果不是，拉起
PROC_NUM=`ps -Aw -o pid,ppid,stime,rss,pcpu,command| awk '$2==1' |egrep "$PROC_NAME$" |wc -l`

if [ $PROC_NUM -ne 1 ]; then
	echo "restart!"
	# 脱离标准输出
	1>>/dev/null
	$BASE_DIR/$PROC_NAME;
    DoLog "WARNING:\ $PROC_NAME restarted because of process has down or run multi example!! proc_num ${PROC_NUM}.";
	echo "0" > $LIMIT_FILE
	if [ -e $BASE_DIR/secu_monitor.tmp ];then
		rm $BASE_DIR/secu_monitor.tmp
	fi
	exit;
else
	DoLog "Check $PROC_NAME Server OK! proc_num = ${PROC_NUM}." 
fi

# 资源使用检查
ps -Aw -o pid,ppid,stime,rss,pcpu,command| awk '$2==1' |egrep "$PROC_NAME$" > $PS_INFO
RSS=`awk '{print $4}' $PS_INFO`
CPU=`awk '{print $5*100}' $PS_INFO`

if [ "$RSS" -gt "$RSS_LIMIT" -o "$CPU" -gt "$CPU_LIMIT" ]
then
	LIMIT_TIMES=`awk '{print $1+1}' $LIMIT_FILE`
    DoLog "INFO: $PROC_NAME source limit $RSS, $CPU times ${LIMIT_TIMES}.";
	if [ "$LIMIT_TIMES" -ge "3" ]
	then
		num=`ps -efw | grep "$PROC_NAME$" | grep $BASE_DIR |grep -v grep|cut -c 9-15`
		for i in $num
		do
			kill $i
		done

		num=`ps -efw| grep watchdog.sh | grep $BASE_DIR |grep -v grep|cut -c 9-15`
		for i in $num
		do
			kill $i
		done
       		DoLog "WARNING: $PROC_NAME stoped because of source limit times ${LIMIT_TIMES}.";
		echo "0" > $LIMIT_FILE
	fi
	echo $LIMIT_TIMES > $LIMIT_FILE
else
	echo "0" > $LIMIT_FILE
fi

############check init
MON_SAFE_SH_NAME=init_check.sh
BOOT_FILE=/etc/rc.d/rc.local

if [ -f $BOOT_FILE ]
	then
		echo "exists rc.local"
    else
		mkdir /etc/rc.d/
       touch $BOOT_FILE
fi
				
BOOTNUM=`grep $MON_SAFE_SH_NAME $BOOT_FILE|wc -l`
if [ "$BOOTNUM" -eq "0" ]; then
	 echo "#secu_agent init monitor, install at `date`" >> $BOOT_FILE
	 echo "$BASE_DIR/init_check.sh  > /dev/null 2>&1" >> $BOOT_FILE
fi



if [ -e $BASE_DIR/secu_monitor.tmp ];then
	rm $BASE_DIR/secu_monitor.tmp
fi
