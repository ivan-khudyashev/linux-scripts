#!/usr/bin/env bash
# Copyright (C) Khudyashev Ivan, 2019, bahek1983@gmail.com
set -o nounset # save of using not defined variables
set -o errexit # save from ignoring error-exit of commands

VOLUME_CONTAINER_CONFIG="vc_MysqlServerTestConfig"
MYSQL_SERVER_ROOT_PASSWORD="SomeDifficultPassword"
SERVERTEST_CONTAINER_NAME="MysqlTestServer"
