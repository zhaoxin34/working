#!/bin/bash
#
# bash index.sh -p [PROFILE] -w [WORKSPACE] [TASK]
#
# 下次迭代目标
# 1 unset 不用的function
# 2 可以tab提示出命令

# shell的目录
DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
WORKSPACE_LIST_FILE=~/.workspace_list_file

CONFIG_DIR=~/.workspace_config
[ ! -d $CONFIG_DIR ] && mkdir -p $CONFIG_DIR

# 引用所有 function
if [ -d $DIR/funcs ]; then
    for f in `ls $DIR/funcs|grep '\.sh'`; do
        . $DIR/funcs/$f
    done
fi

#############################################################
shopt -s expand_aliases
# alias cd="cd && new_cd"
#############################################################
. common/command-line.sh

# 如果环境变量和参数中都没有profile，那么选择一个
[ -z "$PROFILE" ] && select_profile
############################################################
# echo profile and export profile
if [ -f $DIR/profile/$PROFILE ]; then
	. $DIR/profile/$PROFILE
else
	echo_red "Not Found Profile: $DIR/profile/$PROFILE"
	exit 1
fi
clear
print_profile

############################################################
# 获得 workspace 列表
[ -z "$WORKSPACE" ] && select_workspace
[ -z "$WORKSPACE" ] && printf "cd To Your Workspace, and U Can \e[32m[%s]\e[0m\n" "set_workspace"

cd $WORKSPACE && after_cd

echo_green $TASK
############################################################
# 进入命令循环
set -i
HISTFILE=~/.working.history
history -c
history -r

myread() {
	printf "${USER}@${HOSTNAME}[\e[1;32m%s\e[0m] \e[1;33m%s\e[0m `pwd`\n" "$PROFILE" "($ps2)"
    read -e -p ":" $1
    history -s ${!1}
}
trap 'trap_exit' 0 1 2 3 6

function trap_exit() {
	# 如果报错了，那边继续执行
	[ $? -eq 1 ] && return
	history -a;history -w;exit
}


while myread line; do
	# 如果是cd 命令需要执行拦截器
	if [[ "$line" == "cd "* ]]; then
		 eval $line
		 after_cd
		 continue
	fi
	eval $line
done