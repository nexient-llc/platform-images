HOSTNAME ?= registry-1.docker.io
REGION ?= us-east-1
USERNAME ?= replace
TOKEN ?= replace
REPO ?= platform-images
TAG ?= dev
PLATFORM ?= linux/amd64
FILE ?= ./Dockerfiles/Ubuntu/2204/Dockerfile
REGISTRY ?= dockerhub
DOCKERHUB_ORG ?= nexientdevops
PROGRAM ?= docker

ifeq ($(REGISTRY),dockerhub)
  REPO_NAME = $(DOCKERHUB_ORG)/$(REPO)
else
  REPO_NAME = $(HOSTNAME)/$(REPO)
endif

.PHONY: login
login:
ifeq ($(REGISTRY),dockerhub)
	docker login \
		--username $(USERNAME) \
		--password $(TOKEN)
else ifeq ($(REGISTRY),acr)
	az login; \
	token=$$(az acr login -n "$(HOSTNAME)" --expose-token); \
	token=$$(jq -r .accessToken <<<$${token:?}); \
	$(PROGRAM) login "$(HOSTNAME)" -u 00000000-0000-0000-0000-000000000000 -p "$$token"
else ifeq ($(REGISTRY),ecr)
	sh -c "aws --region $(REGION) ecr get-login-password | \
	docker login \
		--username AWS \
		--password-stdin $(HOSTNAME)"
else
	$(error Invalid Registry Provided, received $(REGISTRY))
endif

.PHONY: build
build:
	@set -ex; \
	$(PROGRAM) buildx build \
		--tag "$(REPO):$(TAG)" \
		--platform "$(PLATFORM)" \
		--file "$(FILE)" \
		.

.PHONY: run
run:
	docker run \
		--name $(TAG) \
		--platform=$(PLATFORM) \
		--rm \
		-it $(REPO):$(TAG)

.PHONY: tag
tag:
	$(PROGRAM) image tag "$(REPO):$(TAG)" "$(REPO_NAME):$(TAG)";

.PHONY: push
push:
	@echo "pushing image $(REPO_NAME):$(TAG)"; \
	$(PROGRAM) push "$(REPO_NAME):$(TAG)";

.PHONY: publish
publish: build push

.PHONY: check
check::
	container-structure-test test \
		--image $(REPO):$(TAG) \
		--config test.yaml
