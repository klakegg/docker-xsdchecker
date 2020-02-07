#!/bin/sh

test ! -e /target/dist || rm -rf /target/dist

mkdir -p /target/dist/lib
cp /target/*.jar /target/dist/lib/

cp -r bin /target/dist/
chmod a+x /target/dist/bin/*

cp -r ../schemas /target/dist/xsd

cp ../LICENSE /target/dist/

cd /target/dist

tar -czf ../dist.tar.gz *

apk --no-cache add zip
zip -q ../dist.zip *