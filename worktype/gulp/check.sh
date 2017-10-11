#!/bin/bash

# 判断这个目录是否是docker目录
if [ -f gulpfile.js ]; then
	return 0
else
	return 1
fi
