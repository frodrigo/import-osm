VERSION := $(shell cat VERSION)
LEGACY_VERSION := $(shell cat VERSION)-legacy
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

# Build with custom legacy imposm version
.PHONY: release-legacy
release-legacy:
	docker build \
		--build-arg IMPOSM_REPO="https://github.com/openmaptiles/imposm3.git" \
		--build-arg IMPOSM_VERSION="v2017-10-18" \
		--pull -f Dockerfile -t $(DOCKER_IMAGE):$(LEGACY_VERSION) .
	docker images | grep $(DOCKER_IMAGE) | grep $(LEGACY_VERSION)
