.DEFAULT_GOAL := source_and_build

GIT_VERSION=$(shell git rev-parse --short HEAD)
export GIT_VERSION

source_and_build:
	@. .env && $(MAKE) build

build:
		docker build . -t $(ECR_URL):$(GIT_VERSION) \
			--build-arg GIT_VERSION=$(GIT_VERSION) \
			--build-arg DATABASE_TYPE=$(DATABASE_TYPE) \
			--build-arg BASE_PATH=$(BASE_PATH) \
			-f Dockerfile  >&1
		docker push $(ECR_URL):$(GIT_VERSION)