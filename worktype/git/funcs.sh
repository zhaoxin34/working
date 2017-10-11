#!/bin/bash

function pull() {
	git pull
}

function push() {
	git push
}

function acp() {
	[ -z "$1" ] && echo_red "Usage: acp {message}" && return
	git add . && git commit -m "$1" && git push
}

function branch() {
	branch_name=$1
	[ -z "$branch_name" ] && echo_red "Usage: branch {branch name}" && return
	git branch $branch_name && git checkout && git push --set-upstream origin $branch_name
}
