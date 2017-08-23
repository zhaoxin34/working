#!/bin/bash
# 选择、设置workspace

function __get_workspace_dir_from_line() {
	line=$1
	echo $line|cut -d';' -f1
}

function __get_workspace_name_from_line() {
	line=$1
	echo $line|cut -d';' -f2
}

function select_workspace() {
	echo_yellow "=========  Select Workspace To Go   =========="
	[ ! -f $WORKSPACE_LIST_FILE ] && touch $WORKSPACE_LIST_FILE
	[ `cat $WORKSPACE_LIST_FILE | wc -l` -eq 0 ] && echo "There Is No Workspace in $WORKSPACE_LIST_FILE" && return
	# [ ! $? -eq 0 ] && echo_red "get app list error" && before_exit && exit 1
	awk -F';' '{printf "%d. \033[1;32m%s\033[39m: %s\n", NR, $2, $1}' $WORKSPACE_LIST_FILE

	workspace_n=""
	while [ -z "$workspace_n" ]; do
	    echo "Input The Workspace Number:"
	    read workspace_n
	    WORKSPACE=`awk -F';' 'NR=='$workspace_n'{printf "%s", $1}' $WORKSPACE_LIST_FILE`
	    if [ -z "$WORKSPACE" ]; then
	        workspace_n=""
		echo "Wrong Number, Input again!"
	    fi
	done
}

# 设置工作区
function set_workspace() {
	name=$1
	WORKSPACE="$(pwd)"

	full_name="$WORKSPACE;$name"
	string_in_file $WORKSPACE_LIST_FILE "$full_name"
	# 如果命令不在workspace里面，那么就写进去
	[ $? -eq 0 ] && echo "$full_name" >> $WORKSPACE_LIST_FILE
}
