############################################################
# define up function
function __echo_command() {
	printf "running >>>>> \e[32m[%s]\e[0m\n" "$*"
}
function up() {
	command="docker-compose up -d $1"
	__echo_command "$command"
	$command
}

function restart() {
	command="docker-compose restart $1"
	__echo_command "$command"
	$command

}

############################################################
# define stop function
function stop() {
	command="docker-compose stop $1"
	__echo_command "$command"
	$command
}

############################################################
# define remove function
function rm() {
	command="docker-compose rm $1"
	__echo_command "$command"
	$command
}

############################################################
# define remove function
function exec() {
	command="docker-compose exec $*"
	__echo_command "$command"
	$command
}

function config() {
	command="docker-compose config"
	__echo_command "$command"
	$command
}

function logs() {
	docker-compose logs $*
}

function ps() {
	command="docker ps"
	__echo_command "$command"
	$command
}

function top() {
	command="docker-compose top"
	__echo_command "$command"
	$command
}

function service() {
	[ -z "$1" ] && echo_red "Use: service {service_name}" && return 1
	service_name=$1
	while true; do
		printf "Select A Command To Run In [\e[1;32m%s\e[0m]\n" "$service_name"
		# cat $DIR/service/$service_name/cmd_list| awk '{printf "\t%s. \033[1;32m%s\033[39m\n", NR, $0}'
		echo -e "\t0. exit"
		cat $(pwd)/service/$service_name/cmd_list| awk '{printf "\t%s. %s\n", NR, $0}'
		command_n=""
	    read command_n
	    case ${command_n%% *} in
	        exit )  echo_yellow "exit"; break ;;
	        "0"  )  echo_yellow "exit"; break ;;
	        *    ) ;;
	    esac
	    echo_green "****************************************************************************"

		command=`cat $(pwd)/service/$service_name/cmd_list| awk '{if(NR=='$command_n') {printf $0} }'`
		command="docker-compose exec $service_name $command"
		__echo_command $command
		$command
	done
}

function ssh() {
	[ -z "$1" ] && echo_red "Use: ssh {service_name}" && return 1
	command="docker-compose exec $1 /bin/bash"
	__echo_command "$command"
	$command
}