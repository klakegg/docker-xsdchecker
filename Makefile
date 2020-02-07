.PHONY: graal dist

jar:
	@docker run --rm -i \
		-v $(shell pwd)/java:/src \
		-v $(shell pwd)/target:/target \
		--workdir /src \
		maven:3.6-jdk-8-slim \
		sh build.sh

dist:
	@docker run --rm -i \
		-v $(shell pwd):/src \
		-v $(shell pwd)/target:/target \
		--workdir /src/dist \
		alpine:3.11 \
		sh build.sh

graal:
	@docker build -t klakegg/xsdchecker:snapshot .
	@docker run --rm -i \
		-v $(shell pwd)/target:/target \
		--entrypoint cp \
		klakegg/xsdchecker:snapshot \
		/bin/xsdchecker /target/xsdchecker