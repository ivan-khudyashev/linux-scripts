#!/usr/bin/env bash
# Copyright (C) Khudyashev Ivan, 2019, bahek1983@gmail.com
set -o nounset # save of using not defined variables
set -o errexit # save from ignoring error-exit of commands

VOLUME_CONTAINER_CONFIG="vc_MysqlServerTestConfig"
MYSQL_SERVER_ROOT_PASSWORD="SomeDifficultPassword"
SERVERTEST_CONTAINER_NAME="MysqlTestServer"
# Source common variables and rewrite defaults
source commonMysqlTestVars.sh

primary_action() {
    # TODO: tune define IP-address of Mysql Server
    # Check if server container running
    if [ -z "$(docker ps | grep "${SERVERTEST_CONTAINER_NAME}")" ]
    then
        printf "Server not started. Please start server in docker container: ${SERVERTEST_CONTAINER_NAME}"
        return -1
    fi
    # Define internal IP address of server container
    local SERVERTEST_IP_ADDRESS="$(\
        docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
        "${SERVERTEST_CONTAINER_NAME}" \
    )"
    # Start Mysql Client Container
    docker run --rm -it --volumes-from "${VOLUME_CONTAINER_CONFIG}" \
    mysql:5.7 mysql -h ${SERVERTEST_IP_ADDRESS} --password="${MYSQL_SERVER_ROOT_PASSWORD}"
}

# Main function for execution
main() {
    local COPYRIGHT_MESSAGE="Copyright (C) Khudyashev Ivan, 2019"
    local GREETING_MESSAGE="Mysql Client connect to Test Mysql Server 5.7"
    printf "%s\n%s\n" "${COPYRIGHT_MESSAGE}" "${GREETING_MESSAGE}"
    primary_action
}

# Entry point
main
