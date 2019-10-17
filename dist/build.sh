#!/bin/sh

apk --no-cache add zip

# Create build folder
mkdir -p /tmp/build /target

# Delete old dist
test -e /target/dist && rm -rf /target/dist

# Copy files
cp -r root /target/dist

# Create lib folder
mkdir -p /target/dist/lib

# Compile class
javac \
  -d /tmp/build \
  /src/Main.java

# Generate jar
jar \
  -cfe /target/dist/lib/xsdchecker.jar Main \
  -C /tmp/build \
  Main.class

# Create zip
test -e /target/dist.zip && rm -rf /target/dist.zip
cd /target/dist && zip -9r ../dist.zip .

test -e /target/dist.tar.gz && rm -rf /target/dist.tar.gz
cd /target/dist && tar -zcvf ../dist.tar.gz *
