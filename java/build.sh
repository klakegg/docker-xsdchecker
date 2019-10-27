#!/bin/sh

# This file is triggered by make inside a Docker image.

set -e
set -u

mvn -B --no-transfer-progress clean package

cp /src/target/xsdchecker.jar /target/
