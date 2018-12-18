############################################################
gulp_docker_name=''
function __create_gulp_docker() {
	docker_name=$1
	src_dir=$2
	dest_dir=$3
	port=$4
	# check running
	y_or_n=""
	while [ -z "$y_or_n" ]; do
		echo "Remove Old Container? [y/n]"
		read y_or_n
		[ "$y_or_n" == "y" ] && docker stop $docker_name && docker rm $docker_name
	done

	num=$(docker ps -a | grep $docker_name | wc -l)
	if [ $num -eq 0 ]; then
		echo_green "docker creating ..."
		docker run -it --name $docker_name -v $src_dir:/root/working/src -v $dest_dir:/root/working/dest -p $port -d gulp
	else
		echo_green "docker restarting ..."
		docker restart $docker_name
	fi
}

function init() {
	echo_yellow "Init Gulp:"
	# 截取/后的目录作为工程名
	project_name=$(pwd)
	project_name=${project_name##*/}

	get_input_and_write_to_file \
	'Input Gulp Dest Dir:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"./build" \
	gulp_dest_dir $CONFIG_DIR/gulp_dest_dir_${project_name}

	get_input_and_write_to_file \
	'Input Gulp Docker Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"gulp_name" \
	gulp_docker_name $CONFIG_DIR/gulp_docker_name_${project_name}
	ps2=$gulp_docker_name

	get_input_and_write_to_file \
	'Input Gulp Docker Port:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"3000" \
	gulp_docker_port $CONFIG_DIR/gulp_docker_port_${project_name}

	mkdir -p $gulp_dest_dir
	src_dir=$(pwd)
	dest_dir=$(cd ${gulp_dest_dir}; pwd)

	y_or_n=""
	while [ -z "$y_or_n" ]; do
		printf "\e[33mDocker Name: %s\nSrc Dir: %s\nDest Dir: %s\e[0m: [y/n]\n" $gulp_docker_name $src_dir $dest_dir
		read y_or_n
		[ "$y_or_n" == "y" ] && __create_gulp_docker $gulp_docker_name $src_dir $dest_dir $gulp_docker_port
	done
}

function gulp() {
	docker exec -it $gulp_docker_name gulp $*
}

function npm() {
	docker exec -it $gulp_docker_name cnpm $*
}

function stop() {
	echo 'docker stop $gulp_docker_name'
	docker stop $gulp_docker_name
}

init