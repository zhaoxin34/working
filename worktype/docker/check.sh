#!/bin/bash

# 判断这个目录是否是docker目录
if [ -f docker-compose.yml ]; then
	print_service_list
	return 0
else
	return 1
fi
