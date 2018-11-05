USER=gdiener
TAG=latest

.DEFAULT_GOAL := all

build:
	docker build -t $(USER)/${IMAGE}:${TAG} .

push:
	docker push $(USER)/${IMAGE}:${TAG}

build_all:
	IMAGE=ansible $(MAKE) build

push_all:
	IMAGE=ansible $(MAKE) push

all: build_all push_all