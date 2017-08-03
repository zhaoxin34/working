#!/bin/bash

function pull() {
	git pull
}

function push() {
	git push
}

function acp() {
	git add . && git commit -m "$1" && git push
}
