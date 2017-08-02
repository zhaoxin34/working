#!/bin/bash
#
# bash index.sh -p [PROFILE] -w [WORKSPACE] [TASK]

# shell的目录
DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
workspace_list_file=~/.workspace_list_file

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
	printf "${USER}@${HOSTNAME}[\e[1;32m%s\e[0m] `pwd`\n" "$PROFILE"
    read -e -p ":" $1
    history -s ${!1}
}
trap 'history -a;history -w;exit' 0 1 2 3 6


while myread line; do
	# 如果是cd 命令需要执行拦截器
	if [[ "$line" == "cd "* ]]; then
		 eval $line
		 after_cd
		 continue
	fi
	eval $line
done