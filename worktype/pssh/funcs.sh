#!/bin/bash
# list connection
pssh=""

# 使用数据库
function use() {
	pssh=$1
	if [ -z "$pssh" ]; then
		list
		get_input_and_write_to_file \
		'Input Pssh Service Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
		"" \
		pssh $CONFIG_DIR/pssh
	fi

	ps2="pssh=$pssh"
	echo_green "Host List:"
	cat $pssh/hosts
	echo_green "Args:"
	cat $pssh/args
	docker run -it --rm -v $(pwd)/$pssh:/root/ pssh /bin/bash
}

function list() {
	printf "List of Service: \n\e[33m%s\e[0m\n" "$(ls)"
}

list