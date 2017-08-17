#!/bin/bash

function string_in_file() {
	file=$1
	str=$2
	[ ! -f $file ] && return 0
	list=(`cat $file`)
	[ ${#list[@]} -eq 0 ] && return 0
	# [ ! $? -eq 0 ] && echo_red "get app list error" && before_exit && exit 1
	for (( i=0; $i<${#list[@]}; i++)); do
		[ "${list[i]}" == $str ] && return 1
	done
	return 0
}
