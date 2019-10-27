#!/bin/sh

# This file is triggered by make inside a Docker image.

# Create native image
native-image \
  --static \
  --no-fallback \
  --allow-incomplete-classpath \
  -jar /target/xsdchecker.jar \
  -H:Name=/target/bin/xsdchecker \
  -H:+ReportExceptionStackTraces \
  -H:ReflectionConfigurationFiles=/src/graal/java-xerces.json \
  -H:IncludeResourceBundles=com.sun.org.apache.xerces.internal.impl.msg.XMLSchemaMessages
