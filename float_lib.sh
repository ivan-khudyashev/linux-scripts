#!/usr/bin/env bash
set -o nounset # save for using undeclare variable
set -o errexit # immediately exit on error, save from continue work on error
# Add support for floats in bash
# Add some function wich emulate float calculation ...
# 0. Define variables
# 1. Check input params if exists
# 2. Start actions
function get_integer_part {
    if [[ "${#}" -ne 1 ]]; then
        printf "%s\n" "function get_integer_part(): Wrong ammount of arg"
        return -1
    fi
    local var_value=${1%%.*}
    if [[ -z "${var_value}" ]]; then
        var_value=0
    fi
    echo ${var_value}
}

function get_reminder_part {
    if [[ "${#}" -ne 1 ]]; then
        printf "%s\n" "function get_reminder_part(): Wrong ammount of arg"
        return -1
    fi
    local var_value=${1##*.}
    if [[ "${var_value}" == "${1}" || -z "${var_value}" ]]; then
        var_value=0
    fi
    echo ${var_value}
}

function add_float {
    # Check is enough arguments
    if [[ "${#}" -ne 2 ]]; then
        printf "%s\n" "function add_float(): Wrong ammount of arg"
        return -1
    fi
    # Get integer and reminder part of arguments
    local num1_int="$(get_integer_part ${1})"
    local num1_rem="$(get_reminder_part ${1})"
    local num2_int="$(get_integer_part ${2})"
    local num2_rem="$(get_reminder_part ${2})"

#    printf "%s %s %s %s \n" "1n int: ${num1_int}" "1n rem: ${num1_rem}" "2n int: ${num2_int}" "2n rem: ${num2_rem}"
    # Align reminders
    local len_rem1=${#num1_rem}
    local len_rem2=${#num2_rem}
    local max_rem_len=$(\
    [[ ${#num1_rem} -gt ${#num2_rem} ]] && echo ${#num1_rem} || echo ${#num2_rem}\
    )
    # ...
    # Summing reminders
    local sum_reminders=$((${num1_rem}+${num2_rem}))
    local carry=0
    # ...
    # Summing integers and carry from reminder
}

function test_float {
    add_float 1.3328 2.435
}
test_float 
