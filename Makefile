REPO?=guyzyl/ks-installer
TAG:=$(shell git rev-parse --abbrev-ref HEAD | sed -e 's/\//-/g')-dev-$(shell git rev-parse --short HEAD)
CONTAINER_CLI?=docker

.PHONY: prepare build push buildx

prepare:
	$(CONTAINER_CLI) buildx create --append --use --name ks-installer || $(CONTAINER_CLI) buildx use ks-installer

build: prepare
	$(CONTAINER_CLI) buildx build --load --platform=linux/amd64 . --file Dockerfile --tag $(REPO):$(TAG)

push:
	$(CONTAINER_CLI) push $(REPO):$(TAG)

buildx: prepare
	$(CONTAINER_CLI) buildx build --push --platform=linux/amd64,linux/arm64 . --file Dockerfile --tag $(REPO):$(TAG)

all: build push
