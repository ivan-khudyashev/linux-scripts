#!/usr/bin/env bash
set -o nounset
set -o errexit
# This script repack deb-packages in deb with same name but packed with gzip
# This is necessary if used old `dpkg` utility with new deb-packages
TMPDIR=/tmp/dpkg_repack_dir
DEBFILE=
# 0. Preliminary test if argument is supplied
if [ -z "$1" ]
then
    echo "It is necessary supply first argument: deb-package for repack"
    exit 1
fi
# 1. Now check if first arg is existing file
if [ -n "$1"  ]
then
    if [ -f "$1"  ]
    then
        DEBFILE="$1"
    fi
fi
if [ -z ${DEBFILE} ]
then
    echo "Deb-package file < $1 > not exists"
    exit 1
fi
#TODO: check found deb-file by extension: that this exactly deb
#TODO: check found deb-file by content: that this exactly deb
# 3. Check if tmp directory exists
if [ -n  ${TMPDIR} ]
then
    rm -rf ${TMPDIR}
fi
# 4. Create temp-directory for work
mkdir ${TMPDIR}
# 5. Extract and unpack deb-package in temp-directory
dpkg-deb -x "${DEBFILE}" "${TMPDIR}/"
dpkg-deb -e "${DEBFILE}" "${TMPDIR}/DEBIAN"
# 6. Repack deb-package with gzip
dpkg-deb -Zgzip -b "${TMPDIR}/" .
echo "Repack ${DEBFILE}"
