#!/bin/bash

b=(1 2 3,
4 5 6,
7 8 9)

if [ -z "${b[*]}" ];then
	echo 111
else
	echo 333
fi
