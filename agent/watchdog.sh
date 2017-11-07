#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname "$SCRIPT_PATH")

AGENT_PROC=secu-tcs-agent
PidFile=${BASE_DIR}/"watchdog.pid"

# 不打日志
function DoLog()
{
	CUR_TIME=`date +"%Y-%m-%d %H:%M:%S"`;
	#echo "[$CUR_TIME] $1" >> $BASE_DIR/watchdog.log;
}

# 判断是否已经有watchdog.sh实例在运行，如果有，本实例就退出
if [[ -f "$PidFile" ]]; then
	Timestamp=`date +%s`
	PidFileModTime=`stat -c %Y $PidFile`
	if (($Timestamp < $PidFileModTime + 120)); then
		DoLog "watchdog.sh is running"
		exit -1
	fi
else
	echo "$$" > "$PidFile"
fi

while((1))
do
	# 更新时间
	touch $PidFile
	
	# 日志文件大小超限时，清除
	if [ -e $BASE_DIR/watchdog.log ];then
		LOG_FILE_SIZE=`stat --format=%s $BASE_DIR/watchdog.log`;
		if [ $LOG_FILE_SIZE -gt 10240 ]; then
			rm $BASE_DIR/watchdog.log;
		fi
	fi
	
	# 判断是否已经有watchdog.sh实例在运行，如果有或者ps损坏(为0)，本实例就退出
	WATCHDOG_NUM=`ps -efw  | grep watchdog.sh | grep $BASE_DIR  | grep -v grep | wc -l`;
	if [ $WATCHDOG_NUM -gt 2 -o -e 0 ];then
		DoLog "watchdog.sh has already run, watchdog_num: $WATCHDOG_NUM";
		exit;
	fi
	# 判断是否洋葱agent正在运行中，如果不是，启动它
	ONION_AGENT_NUM=`ps -efw | grep "$AGENT_PROC$" | grep $BASE_DIR | grep -v grep | wc -l`;
	if [ $ONION_AGENT_NUM -ne 1 ];then
		DoLog "onion agent does not run, start it. onion_agent_num: $ONION_AGENT_NUM";
		1>>/dev/null
		$BASE_DIR/secu-tcs-agent-mon-safe.sh;
	else
		DoLog "onion agent has already run, onion_agent_num: $ONION_AGENT_NUM";
	fi
	
	sleep 60;
done
