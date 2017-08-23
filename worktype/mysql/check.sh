#!/bin/bash

# 判断这个目录是否git
last_level_dir=$(pwd)
last_level_dir=${last_level_dir##*/}
if [ "$last_level_dir" == "mysql" ]; then
	return 0
else
	return 1
fi
