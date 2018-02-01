# Makefile template for easy Docker development
none:

build:
	docker build -t stevekm/nextflow-demo .

build-clean:
	docker build --no-cache -t stevekm/nextflow-demo .

build-test:
	docker run --rm -ti stevekm/nextflow-demo

docker-demo:
	docker run --privileged --rm -ti debian:jessie /bin/bash
