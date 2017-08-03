#!/bin/bash

# 判断这个目录是否git
if [ -d .git ]; then
	return 0
else
	return 1
fi
