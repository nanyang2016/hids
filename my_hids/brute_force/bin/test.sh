#!/bin/bash

arr=("aa")

arr[${#arr[@]}]=bbb
echo ${#arr[@]}
	
[[ ${arr[@]} =~ bbb ]] && echo ok
