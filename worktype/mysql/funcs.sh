#!/bin/bash
# list connection
service=""
conn=""

# 使用数据库
function use() {
	list
	get_input_and_write_to_file \
	'Input Mysql Database Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"" \
	service $CONFIG_DIR/service

	ps2="serivce=$service"
	[ -f $service/connect ] && conn=`cat $service/connect` || echo_red "No connection File"
}

function list() {
	printf "List of Service: \n\e[33m%s\e[0m\n" "$(ls)"
}


function connect() {
	echo $conn
	$conn
}

# show databases
function ld() {
	printf "List of Database: \n\e[33m%s\e[0m\n" "$(echo 'show databases'|$conn)"
}

# show tables
function lt() {
	printf "List of Tables: \n\e[33m%s\e[0m\n" "$(echo 'show tables'|$conn)"
}

# add table column
function add_column() {
	lt
	get_input_and_write_to_file \
	'Input Mysql Table Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"" \
	table_name $CONFIG_DIR/table_name

	get_input_and_write_to_file \
	'Input Mysql Column Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"" \
	column_name $CONFIG_DIR/column_name

	get_input_and_write_to_file \
	'Input Mysql Column Type:[\e[1;32m%s\e[0m]? [ENTER]|Input New One(int(11), varchar(128), smallint, date, datetime, timestamp) [ENTER]\n' \
	"" \
	column_type $CONFIG_DIR/column_type

	get_input_and_write_to_file \
	'Input Mysql Column Comment:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"" \
	column_comment $CONFIG_DIR/column_comment

	get_input_and_write_to_file \
	'Is Null?:[\e[1;32m%s\e[0m]? [ENTER] | null | not null [ENTER]\n' \
	"" \
	column_is_null $CONFIG_DIR/column_is_null

	get_input_and_write_to_file \
	'Default:[\e[1;32m%s\e[0m]? [ENTER] | default {default_value} [ENTER]\n' \
	"" \
	column_default $CONFIG_DIR/column_default

	sql="ALTER TABLE $table_name ADD $column_name $column_type $column_is_null $column_default COMMENT '$column_comment'"
	y_or_n=""
	while [ -z "$y_or_n" ]; do
		printf "The Sql is \e[33m%s\e[0m: [y/n]\n" "$sql"
		read y_or_n
		[ "$y_or_n" == "y" ] && echo $sql|$conn && show_create $table_name
	done
}

# 显示创建表
function show_create() {
	table_name=$1
	if [ -z "$table_name" ]; then
		lt

		get_input_and_write_to_file \
		'Input Mysql Table Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
		"" \
		table_name $CONFIG_DIR/table_name
	fi
	echo "show create table $table_name"|$conn
}

function show_column() {
	table_name=$1
	if [ -z "$table_name" ]; then
		lt

		get_input_and_write_to_file \
		'Input Mysql Table Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
		"" \
		table_name $CONFIG_DIR/table_name
	fi
	echo "show columns from $table_name"|$conn
}

function drop_column() {
	lt
	get_input_and_write_to_file \
	'Input Mysql Table Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"" \
	table_name $CONFIG_DIR/table_name

	show_column $table_name

	get_input_and_write_to_file \
	'Input Mysql Column Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"" \
	column_name $CONFIG_DIR/column_name

	sql="alter table $table_name drop column $column_name"
	y_or_n=""
	while [ -z "$y_or_n" ]; do
		printf "The Sql is \e[33m%s\e[0m: [y/n]\n" "$sql"
		read y_or_n
		[ "$y_or_n" == "y" ] && echo $sql|$conn --silent && echo "show create table $table_name"|$conn
	done
}

use