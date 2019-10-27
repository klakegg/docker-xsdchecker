#!/bin/sh

test -e /target/xsdchecker.jar || sh /src/java/build.sh

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
