#!/bin/bash

function print_command_txt() {
	work_type=$1
	command_txt=$2

	# 打印命令提示
	echo_yellow "Input Command:"
	cat $command_txt | awk -F'\t' '{print "\t" $1 "\t\033[1;32m" $2 " " "\033[37m\t" $3 "\033[39m"}'
}
