#!/bin/bash


OLD_IFS=$IFS
IFS=$'\n'
for one_line in $(cat /var/log/auth.log|head)
do
	echo $i"$one_line"
	((i++))
done
IFS=$OLD_IFS




