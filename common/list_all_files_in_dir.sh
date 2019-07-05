#!/usr/bin/env bash
set -o nounset # save for using undeclare variable
set -o errexit # immediately exit on error, save from continue work on error
# Script for list all files in dir
#  List all files in directory and all subdirectories
# 0. Define variables
search_dir=.
# 1. Check input params if exists
# 2. Start actions
for entry in `ls ${search_dir}`; do
    if [[ -d ${entry} ]] ; then
    else
        echo ${entry}
    fi
done
