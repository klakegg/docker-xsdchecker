# Build project using Maven
FROM maven:3.6-jdk-8-slim AS maven

COPY java /src/java

RUN cd /src/java \
 && mvn -B --no-transfer-progress clean package


# Create native image
FROM klakegg/graalvm-native AS graalvm

COPY graal /src/graal
COPY --from=maven /src/java/target/xsdchecker.jar /target/xsdchecker.jar

RUN cd /src/graal && sh build.sh


# Combine files
FROM scratch AS tmp

COPY --from=graalvm /target/bin/xsdchecker /bin/xsdchecker
COPY schemas /schemas
COPY graal/run.sh /run.sh


# Final image
FROM alpine:3.10

COPY --from=tmp / /

VOLUME /src

WORKDIR /src

ENTRYPOINT ["sh", "/run.sh"]
