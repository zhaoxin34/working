#!/bin/bash
# . $home/common/common.sh
# 部署步骤数组
process=('Select App' 'Git Path' 'Module Name' 'Dist' 'Package' 'App Host' 'End')
function print_header_inner() {
	p=("$@")
    for (( pi=0; $pi<${#process[@]}; pi++)); do
		l=$((pi+1)).${process[pi]}
		if [ ! -z "${p[pi]}" ]; then
			printf "\e[32m%s\t: %s\e[0m\n" "$l" "${p[pi]}"
		else
			echo $l
		fi
    done
}

function print_header() {
    # 清屏
    printf "\033[2J\033[0;0H"
	echo "======================================== Joky Auto Deployment ================================"
	print_header_inner "$@"
	echo "=================================================================================================="
}

#print_header abc sdflj sdlkfj slkdjfslfj
