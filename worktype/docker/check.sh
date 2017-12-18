#!/bin/bash

# 判断这个目录是否是docker目录
if [ -f docker-compose.yml ]; then
	PROFILE_FILE=profile/$PROFILE
	[ -f $PROFILE_FILE ] || echo_red "ENV File \"$PROFILE_FILE\" Not Exists!!!"
	echo_green "Profile File:"
	cat $PROFILE_FILE
	. $PROFILE_FILE
	# print_service_lis
	docker-compose config --services
	return 0
else
	return 1
fi
