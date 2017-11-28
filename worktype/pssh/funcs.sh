#!/bin/bash

docker_name=pssh-instance
# 使用数据库
function connect() {
	y_or_n=""
	while [ -z "$y_or_n" ]; do
		echo "Remove Old Container? [y/n]"
		read y_or_n
		[ "$y_or_n" == "y" ] && docker stop $docker_name && docker rm $docker_name
	done
	c=`docker ps -a|grep $docker_name|wc -l`
	if [ $c -eq 0 ]; then
		docker run -it -h pssh --name $docker_name -v $(pwd):/root/ pssh /bin/bash
	else
		docker restart $docker_name && docker exec -it $docker_name /bin/bash
	fi
}

function list() {
	printf "List of Service: \n\e[33m%s\e[0m\n" "$(ls)"
}

list
connect