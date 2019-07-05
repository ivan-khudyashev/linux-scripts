#!/usr/bin/env bash
# Copyright (C) Khudyashev Ivan, 2019, bashek1983@gmail.com
set -o nounset # save of using not defined variables
set -o errexit # save from ignoring error-exit of commands

VOLUME_CONTAINER_CONFIG="vc_MysqlServerTestConfig"
MYSQL_SERVER_ROOT_PASSWORD="SomeDifficultPassword"
SERVERTEST_CONTAINER_NAME="MysqlTestServer"
# Source common variables and rewrite defaults:
#  - VOLUME_CONTAINER_CONFIG
#  - MYSQL_SERVER_ROOT_PASSWORD
#  - SERVERTEST_CONTAINER_NAME
source commonMysqlTestVars.sh
VOLUME_CONTAINER_DATADIR="vc_MysqlServerTestDataDir"
LOCAL_CONFIG_DIR="${HOME}"/storage/dbms/mysql/configs/testConfig
CONTAINER_CONFIG_DIR="/etc/mysql/conf.d"
LOCAL_DATA_DIR="${HOME}"/storage/dbms/mysql/dataDirs/testData
CONTAINER_DATA_DIR="/var/lib/mysql"

start_vc_config() {
    docker run --name "${VOLUME_CONTAINER_CONFIG}" \
    -v "${LOCAL_CONFIG_DIR}":"${CONTAINER_CONFIG_DIR}" \
    alpine echo start mysql config container
    printf "Config container has started!\n"
}

start_vc_datadir() {
    docker run --name "${VOLUME_CONTAINER_DATADIR}" \
    -v "${LOCAL_DATA_DIR}":"${CONTAINER_DATA_DIR}" \
    alpine echo start mysql datadir container
    printf "DataDir container has started!\n"
}

primary_action() {
    # Check if all volume container exists
    if [ -z "$(docker ps -a | grep "${VOLUME_CONTAINER_CONFIG}")" ]
    then
        printf "Not exists volume config container: ${VOLUME_CONTAINER_CONFIG}\nTry start ...\n"
        start_vc_config
    fi
    if [ -z "$(docker ps -a | grep "${VOLUME_CONTAINER_DATADIR}")" ]
    then
        printf "Not exists volume config container: ${VOLUME_CONTAINER_DATADIR}\nTry start ...\n"
        start_vc_datadir
    fi
    # Start/restart docker
    if [ -n "$(docker ps | grep "${SERVERTEST_CONTAINER_NAME}")" ]
    then
        # If container exists nothing to Do
        printf "Mysql Server Container is already start\n"
    else
        if [ -n "$(docker ps -a | grep "${SERVERTEST_CONTAINER_NAME}")" ]
        then
            # Container exists -> just start it
            printf "Restart Mysql Server Container\n"
            docker start "${SERVERTEST_CONTAINER_NAME}"
        else
            # Container not exists. Run new container
            printf "Start Mysql Server Container ...\n"
            docker run -d --name "${SERVERTEST_CONTAINER_NAME}" \
            -e MYSQL_ROOT_PASSWORD="${MYSQL_SERVER_ROOT_PASSWORD}" \
            --volumes-from "${VOLUME_CONTAINER_CONFIG}" \
            --volumes-from "${VOLUME_CONTAINER_DATADIR}" mysql:5.7
            printf "Mysql Server Container has started\n"
        fi
    fi
    # TODO: check if this image already start
}

# Main function for execution
main() {
    local COPYRIGHT_MESSAGE="Copyright (C) Khudyashev Ivan, 2019"
    local GREETING_MESSAGE="Mysql Server 5.7 StartInDocker Script"
    printf "%s\n%s\n" "${COPYRIGHT_MESSAGE}" "${GREETING_MESSAGE}"
    primary_action
}

# Entry point
main
