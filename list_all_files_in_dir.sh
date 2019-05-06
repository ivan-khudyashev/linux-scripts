#!/bin/bash
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
