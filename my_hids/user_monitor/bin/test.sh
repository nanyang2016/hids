#!/bin/bash

b=(1 2 3,
4 5 6,
7 8 9)

while read line
do
	echo "$line"

done < /etc/passwd
