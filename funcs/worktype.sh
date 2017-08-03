#!/bin/bash
# 打印work空间类型并加载对应方法

function worktype() {
	log.debug "checking1..."
	works=(`ls $DIR/worktype`)
	for (( i=0; $i<${#works[@]}; i++)); do
		# 判断这个目录的类型
		work_type=${works[i]}
		[ -f $DIR/worktype/${work_type}/check.sh ] || continue
		log.debug "checking..."
		. $DIR/worktype/${works[i]}/check.sh
		# 如果没过check，退出
		[ $? -ne 0 ] && continue
		# 加载功能
		. $DIR/worktype/${work_type}/funcs.sh
		# 打印命令提示
		# echo $work_type
		print_command_txt ${work_type} $DIR/worktype/$work_type/command_txt
	done
}
