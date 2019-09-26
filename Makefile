VERSION := $(shell cat VERSION)
DOCKER_IMAGE := sophox/import-osm

.PHONY: build
build:
	@echo "Build: $(VERSION)"
	docker build -f Dockerfile      -t $(DOCKER_IMAGE):$(VERSION)      .
	docker images | grep $(DOCKER_IMAGE) | grep $(VERSION)

.PHONY: release
release:
	@echo "Release: $(VERSION)"
	docker build --pull -f Dockerfile      -t $(DOCKER_IMAGE):$(VERSION)      .
	docker images | grep $(DOCKER_IMAGE) | grep $(VERSION)
