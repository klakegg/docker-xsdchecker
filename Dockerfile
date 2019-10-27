# Build project using Maven
FROM maven:3.6-jdk-8-slim AS maven

COPY java /src/java

RUN cd /src/java \
 && mvn -B --no-transfer-progress clean package


# Create native image
FROM klakegg/graalvm-native AS graalvm

COPY graal /src/graal
COPY --from=maven /src/java/target/xsdchecker.jar /target/xsdchecker.jar

RUN cd /src/graal \
 && sh build.sh


# Combine files
FROM alpine:3.10 AS tmp

COPY --from=graalvm /target/bin/xsdchecker /files/bin/xsdchecker-official
COPY schemas /files/schemas
COPY graal/run.sh /files/bin/xsdchecker

RUN chmod a+x /files/bin/*
RUN ln -s /bin/xsdchecker /files/bin/xc


# Final image
FROM alpine:3.10

COPY --from=tmp /files /

VOLUME /src

WORKDIR /src

ENTRYPOINT ["xsdschecker"]
