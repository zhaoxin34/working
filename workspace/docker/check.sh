#!/bin/bash

# 判断这个目录是否是docker目录
if [ -f docker-compose.yml ]; then
	exit 0
else
	exit 1
fi
