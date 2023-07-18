REPO?=guyzyl/ks-installer
TAG:=$(shell git rev-parse --abbrev-ref HEAD | sed -e 's/\//-/g')-dev-$(shell git rev-parse --short HEAD)
CONTAINER_CLI?=docker

build:
	$(CONTAINER_CLI) buildx create --use
	$(CONTAINER_CLI) buildx build --platform=linux/amd64,linux/arm64 . --file Dockerfile --tag $(REPO):$(TAG)
push:
	$(CONTAINER_CLI) push $(REPO):$(TAG)
all: build push
