FROM klakegg/graalvm-native AS graalvm

COPY graal /src/graal
COPY java /src/java

RUN cd /src/graal && sh build.sh


FROM alpine:3.10

COPY --from=graalvm /target/bin/xsdchecker /bin/xsdchecker

VOLUME /src

WORKDIR /src

ENTRYPOINT ["xsdchecker"]
