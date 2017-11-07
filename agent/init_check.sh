#!/bin/bash
#secu-tcs-agent bootstart, install at Fri Oct 12 10:59:02 CST 2016.
SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname "$SCRIPT_PATH")

$BASE_DIR/secu-tcs-agent-mon-safe.sh > /dev/null 2>&1
