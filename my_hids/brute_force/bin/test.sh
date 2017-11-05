#!/bin/bash

#line=`wc -l /var/log/auth.log `
#line=8431
#str=`sed -n "$line,\$p" /var/log/auth.log`

#str=`sed -n "$line,\$p" /var/log/auth.log`
#echo "$str"

line=`cat /var/log/auth.log|head`


#IFS_bak=$IFS
#IFS="\n"
i=1
cat /var/log/auth.log|head > tmp_file
#for one_line in `cat /var/log/auth.log|head`
while read one_line
do
	echo $i"$one_line"
	((i++))
done < tmp_file
#IFS=$IFS_bak




