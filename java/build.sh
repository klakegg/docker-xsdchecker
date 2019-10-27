#!/bin/sh

# Create build folder
mkdir -p /tmp/build /target

# Compile class
javac \
  -d /tmp/build \
  /src/java/src/Main.java

# Generate jar
jar \
  -cfe /target/xsdchecker.jar Main \
  -C /tmp/build \
  Main.class
