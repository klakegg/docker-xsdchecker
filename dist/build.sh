#!/bin/sh

apk --no-cache add zip gettext

test ! -e /target/dist || rm -rf /target/dist

mkdir -p /target/dist/lib
cp /target/*.jar /target/dist/lib/

cp -r bin /target/dist/
chmod a+x /target/dist/bin/*

cp -r ../schemas /target/dist/xsd

cp ../LICENSE /target/dist/

export GITHUB_SHA=${GITHUB_SHA:-snapshot}
export GITHUB_REF=${GITHUB_REF:-local}
cat readme.tpl.md | envsubst > /target/dist/README.md
cat /target/dist/README.md

cd /target/dist

tar -czf ../dist.tar.gz *

zip -q ../dist.zip *