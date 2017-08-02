#!/bin/bash
function print_service_list() {
	# 如果有service目录
	if [ -d service ]; then
		echo_yellow "Service Name List:"
		ls service | awk '{print "\t"$0}'
	fi
}
