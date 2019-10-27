FROM maven:3.6-jdk-8-slim AS maven

COPY java /src/java

RUN cd /src/java \
 && mvn -B --no-transfer-progress clean package


FROM klakegg/graalvm-native AS graalvm

COPY graal /src/graal
COPY --from=maven /src/java/target/xsdchecker.jar /target/xsdchecker.jar

RUN cd /src/graal && sh build.sh


FROM alpine:3.10

COPY --from=graalvm /target/bin/xsdchecker /bin/xsdchecker

VOLUME /src

WORKDIR /src

ENTRYPOINT ["xsdchecker"]
