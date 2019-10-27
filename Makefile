.PHONY: jar graal

graal:
	@docker build -t klakegg/xsdchecker:snapshot .
	@docker run --rm -i \
		-v $(shell pwd)/target:/target \
		--entrypoint cp \
		klakegg/xsdchecker:snapshot \
		/bin/xsdchecker /target/xsdchecker

jar:
	@docker run --rm -i \
		-v $(shell pwd)/java:/src/java \
		-v $(shell pwd)/target:/target \
		--workdir /src/java \
		openjdk:8u212-jdk-alpine3.9 \
		sh build.sh
