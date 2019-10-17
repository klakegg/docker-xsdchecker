#!/bin/sh

set -e
set -u

BASEDIR=$(dirname "$0")

java ${JAVA_OPTS:-} -classpath "$(pwd):$BASEDIR/../lib/*" Main "$@"
