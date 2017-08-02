#!/bin/bash

function get_input_and_write_to_file() {
    msg=$1
	default=$2
    value=""
	file=$4
    [ -f $file ] && value=`cat $file`
    [ -z "$value" ] && value=$default
    printf "$msg" "$value"
	if [ "$auto" != "y" ]; then
        read temp
        if [ -n "$temp" ]; then
            value=$temp
	    fi
	fi
	echo $value > $file
	eval $3='$value'
}
