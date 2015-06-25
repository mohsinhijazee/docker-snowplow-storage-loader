SHELL = /bin/bash
IMAGE_NAME ?= dubizzledotcom/snowplow-storage-loader
IMAGE_VERSION ?= 0.0.1

.PHONY: docker

docker:
		docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .
