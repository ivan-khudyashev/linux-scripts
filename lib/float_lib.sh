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
    printf "%s\n" "${var_value}"
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
    printf "%s\n" "${var_value}"
}

function sum_reminder {
    if [[ "${#}" -ne 2 ]]; then
        printf "%s\n" "function sum_reminder(): Wrong ammount of arg"
        return -1
    fi
    # Define reminder with max length
    local maxlen_rem=${1}
    local minlen_rem=${2}
    local maxlen=${#1}
    local minlen=${#2}
    if [[ ${minlen} -gt ${maxlen} ]]; then
        maxlen=${#2};minlen=${#1};maxlen_rem=${2};minlen_rem=${1}
    fi
    # Align reminders
    local delta_len=$((maxlen-minlen))
    while [[ ${delta_len} -gt 0 ]]; do
        minlen_rem=${minlen_rem}0
        delta_len=$((delta_len - 1))
    done
    # Summing reminders
    local sum_reminders=$((${maxlen_rem}+${minlen_rem}))
    local carry=0
    if [[ ${#sum_reminders} -gt ${maxlen} ]]; then
        carry=${sum_reminders:0:1}
        sum_reminders=${sum_reminders:1}
    fi
    # Return carry and summing reminders in format: carry.sum
    printf "%d.%d\n" ${carry} ${sum_reminders}
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

# DEBUG INPUT
#    printf "%s %s %s %s \n" "1n int: ${num1_int}" "1n rem: ${num1_rem}" "2n int: ${num2_int}" "2n rem: ${num2_rem}"

    local sum_rem_and_carry="$(sum_reminder ${num1_rem} ${num2_rem})"
    local sum_rem_carry="$(get_integer_part ${sum_rem_and_carry})"
    local sum_rem="$(get_reminder_part ${sum_rem_and_carry})"
    printf "%d.%s\n" $((num1_int + num2_int + sum_rem_carry)) ${sum_rem}
}

function test_float {
    add_float 1.3328 2.435
}
test_float 
