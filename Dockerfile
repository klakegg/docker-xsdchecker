FROM klakegg/graalvm-native AS graalvm

COPY graal /src

RUN sh /src/build.sh


FROM alpine:3.10

COPY --from=graalvm /target/bin/xsdchecker /bin/xsdchecker

VOLUME /src

WORKDIR /src

ENTRYPOINT ["xsdchecker"]
