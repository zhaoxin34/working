function select_profile() {
	echo_yellow "=========  Select Run Profile   =========="
	profiles=(`ls $DIR/profile`)
	# [ ! $? -eq 0 ] && echo_red "get app list error" && before_exit && exit 1
	for (( i=0; $i<${#profiles[@]}; i++)); do
	   echo "$i. ${profiles[i]}"
	done

	profile_n=""
	while [ -z "$profile_n" ]; do
	    echo "Input The Profile Number:"
	    read profile_n
	    if [ -z "${profiles[$profile_n]}" ]; then
	        profile_n=""
		echo "Wrong Number, Input again!"
	    fi
	done
	PROFILE=${profiles[$profile_n]}
}