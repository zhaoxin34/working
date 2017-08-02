#!/bin/bash
# Use -gt 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use -gt 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
# note: if this is set to -gt 0 the /etc/hosts part is not recognized ( may be a bug )
while [[ $# -gt 1 ]]
do
    key="$1"

    case $key in
        -p|--profile)
        PROFILE="$2"
        shift # past argument
        ;;
        -w|--workspace)
        WORKSPACE="$2"
        shift # past argument
        ;;
        -*)
        printf "Unknow argument [\e[31m%s\e[0m]\nUseage: bash index.sh -p [PROFILE] -w [WORKSPACE] [TASK]\n" "$1"
        exit 1
        ;;
        *)
        break
        ;;
    esac
    shift # past argument or value
done

if [[ -n $* ]]; then
    TASK=$*
fi