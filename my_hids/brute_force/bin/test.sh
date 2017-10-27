#!/bin/bash

line=`wc -l /var/log/auth.log `
line=8431
#str=`sed -n "$line,\$p" /var/log/auth.log`

str=`sed -n "$line,\$p" /var/log/auth.log`



echo "$str"
