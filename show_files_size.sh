#!/bin/bash
# This script take 1 argument - directory and show size of contents all child elements
#  in this directory
checking_directory=`pwd`
if [ -n  "$1" ]
then
    if [ -d "$1" ]
    then
        checking_directory="$1"
    fi
fi
rm -f /tmp/help_sort_file.tmp
for f in "${checking_directory}/*"
do
    sudo du -sh ${f} >> /tmp/help_sort_file.tmp
done
sort -rh /tmp/help_sort_file.tmp
