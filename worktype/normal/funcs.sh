#!/bin/bash

function sw() {
	set_workspace $*
}

function lw() {
	select_workspace $*
	cd $WORKSPACE && after_cd
}

function h() {
	worktype $*
}

function ll() {
	ls -l
}