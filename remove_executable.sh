#!/bin/bash
# This script remove all executable files from dir in argument
#  If there no argument, then - from current dir
# 0. Define variables
ACTION_DIR=$(pwd)
CNT_FOR_DEL=0
MAX_TO_DEL=2
VERY_MAX_TO_DEL=200
TMP_MAX_TO_DEL=
# 1. Check input params if exists
if [ ! -z "$1" ]
then
    if [ -d "$1" ]
    then
        echo "Redefine dir to $1"
        ACTION_DIR=$1
    fi
fi
if [ ! -z "$2" ]
then
    TMP_MAX_TO_DEL=$2
    if [ ${TMP_MAX_TO_DEL} -gt ${MAX_TO_DEL} ] && [ ${TMP_MAX_TO_DEL} -lt ${VERY_MAX_TO_DEL} ]
    then
        MAX_TO_DEL=${TMP_MAX_TO_DEL}
    else
        if [ ${TMP_MAX_TO_DEL} -gt ${VERY_MAX_TO_DEL} ]
        then
            echo "You input very big maximum for deletion (${TMP_MAX_TO_DEL}). When extreme allowed maximum = ${VERY_MAX_TO_DEL}"
            echo "If you still want to delete, then rewrite this script"
        fi
    fi
fi
# 2. Remove all executables
CNT_FOR_DEL=$(find ${ACTION_DIR} -type f -executable | wc -l)
if [ ${CNT_FOR_DEL} -gt 0 ] && [ ${CNT_FOR_DEL} -lt ${MAX_TO_DEL} ]
then
    rm $(find ${ACTION_DIR} -type f -executable)
else
    if [ ${CNT_FOR_DEL} -gt ${MAX_TO_DEL} ]
    then
        echo "Count executables for deletion (${CNT_FOR_DEL}) greater then maximum (${MAX_TO_DEL})"
        echo "If you still want to delete then pass second script's argument as new maximum"
    fi
fi
echo "Deletion complete"
