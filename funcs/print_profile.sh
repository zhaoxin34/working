#!/bin/bash

function print_profile() {
	printf "Profile=[\e[1;32m%s\e[0m]\n" "$PROFILE"
	echo_yellow "===========$PROFILE environment==============="
	cat $DIR/profile/$PROFILE
	echo
	echo_yellow "=============================================="
}