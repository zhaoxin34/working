#!/bin/bash

function after_cd() {
	# log.debug "new ==============="
	# cd 到目录，如果返回错误直接退出
	# o_cd $*
	# [ $? -ne 0 ] && return
	log.debug "checking1..."
	works=(`ls $DIR/workspace`)
	for (( i=0; $i<${#works[@]}; i++)); do
		# 判断这个目录的类型
		work_type=${works[i]}
		[ -f $DIR/workspace/${work_type}/check.sh ] || return
		log.debug "checking..."
		bash $DIR/workspace/${works[i]}/check.sh
		# 如果没过check，退出
		[ $? -ne 0 ] && return
		# 加载功能
		. $DIR/workspace/${work_type}/funcs.sh
		# 打印命令提示
		echo $work_type
		print_service_list
		print_command_txt ${work_type} $DIR/workspace/$work_type/command_txt
	done
}