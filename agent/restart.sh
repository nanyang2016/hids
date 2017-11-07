#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname "$SCRIPT_PATH")
$BASE_DIR/stop.sh

#ulimit -c 268435456
ulimit -c 0 
ulimit -v 67108864
ulimit -m 67108864
ulimit -u 100
ulimit -n 2048
sleep 5
$BASE_DIR/secu-tcs-agent-mon-safe.sh

exit
