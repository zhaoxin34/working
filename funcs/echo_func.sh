#!/bin/bash
function echo_yellow() {
    printf "\e[33m%s\e[0m\n" "$*"
}

function echo_green() {
    printf "\e[32m%s\e[0m\n" "$*"
}

function echo_red() {
    printf "\e[31m%s\e[0m\n" "$*"
}
