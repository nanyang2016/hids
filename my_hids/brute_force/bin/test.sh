#!/bin/bash

strA="helloworld"
strB="low"

test(){
	if [[ $strA =~ $strB ]]
	then
    		echo "包含"
	else
    		echo "不包含"
	fi
}

test
