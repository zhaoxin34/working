#!/bin/bash
# 选择、设置workspace

function select_workspace() {
	echo_yellow "=========  Select Workspace To Go   =========="
	[ ! -f $workspace_list_file ] && touch $workspace_list_file
	workspace_list=(`cat $workspace_list_file`)
	[ ${#workspace_list[@]} -eq 0 ] && echo "There Is No Workspace in $workspace_list_file" && return
	# [ ! $? -eq 0 ] && echo_red "get app list error" && before_exit && exit 1
	for (( i=0; $i<${#workspace_list[@]}; i++)); do
	   echo "$i. ${workspace_list[i]}"
	done

	workspace_n=""
	while [ -z "$workspace_n" ]; do
	    echo "Input The Workspace Number:"
	    read workspace_n
	    if [ -z "${workspace_list[$workspace_n]}" ]; then
	        workspace_n=""
		echo "Wrong Number, Input again!"
	    fi
	done
	WORKSPACE=${workspace_list[$workspace_n]}
}


# 设置工作区
function set_workspace() {
	WORKSPACE=$(pwd)
	string_inf_file $workspace_list_file $(pwd)
	# 如果命令不在workspace里面，那么就写进去
	[ $? -eq 0 ] && echo $WORKSPACE >> $workspace_list_file
}