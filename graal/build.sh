#!/bin/sh

# Create build folder
mkdir -p /target/build

# Compile class
javac \
  -d /target/build \
  /src/Main.java

# Generate jar
jar \
  -cfe /target/build/main.jar Main \
  -C /target/build \
  Main.class

# Create native image
native-image \
  --static \
  --no-fallback \
  --allow-incomplete-classpath \
  -jar /target/build/main.jar \
  -H:Name=/target/bin/xsdchecker \
  -H:+ReportExceptionStackTraces \
  -H:ReflectionConfigurationFiles=/src/java-xerces.json \
  -H:IncludeResourceBundles=com.sun.org.apache.xerces.internal.impl.msg.XMLSchemaMessages
