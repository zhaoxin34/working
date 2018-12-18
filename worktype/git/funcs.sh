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

function glog() {
	git log --pretty=format:"%h %ar %cn %s" --graph
}

function gShortHash() {
	git rev-parse --short HEAD
}

function mergeBranch() {
	echo_red "Begin Merge Branch"

	get_input_and_write_to_file \
	'Source Branch Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"" \
	git_merge_srouce_branch $CONFIG_DIR/git_merge_srouce_branch

	source_rev=`git rev-parse --short HEAD`

	printf "Current Branch [\e[1;32m%s %s\e[0m]\n" $git_merge_srouce_branch $source_rev

	get_input_and_write_to_file \
	'Destination Branch Name:[\e[1;32m%s\e[0m]? [ENTER]|Input New One [ENTER]\n' \
	"" \
	git_merge_dest_branch $CONFIG_DIR/git_merge_dest_branch

	git checkout $git_merge_dest_branch

	# shwo current branch name
	git status

	dest_rev=`git rev-parse --short $git_merge_dest_branch`
	printf "Current Branch [\e[1;32m%s %s\e[0m]\n" $git_merge_dest_branch $source_rev

	echo_yellow "=============================== Begin Merge Branch ==============================="

	printf "Merge from [\e[1;32m%s\e[0m] To [\e[1;32m%s\e[0m] \n" $git_merge_srouce_branch $git_merge_dest_branch

	echo Create change_log.`date +%Y-%m-%d-%H-%M`
	git log --graph --pretty=short --abbrev-commit ${git_merge_dest_branch}..${git_merge_srouce_branch} > change_log.`date +%Y-%m-%d-%H-%M`

	git merge ${git_merge_srouce_branch}

	git add .
	git commit -m "merge branch from [${git_merge_srouce_branch} $source_rev] to [${git_merge_dest_branch} $dest_rev]"
	git push --set-upstream origin branch/pingan
	echo_red git push success
}
