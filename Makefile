.PHONY: dist graal

graal:
	@docker build -t klakegg/xsdchecker:snapshot .

dist:
	@docker run --rm -i \
		-v $(shell pwd)/dist:/src \
		-v $(shell pwd)/graal/Main.java:/src/Main.java \
		-v $(shell pwd)/target:/target \
		--workdir /src \
		openjdk:8u212-jdk-alpine3.9 \
		sh build.sh
