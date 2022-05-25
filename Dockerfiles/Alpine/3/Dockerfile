FROM alpine:3

ARG CONFTEST_VERSION=0.25.0
ARG OPA_VERSION=0.37.1
ARG TERRAFORM_VERSION=1.1.7
ARG TFLINT_VERSION=0.34.1
ARG SBOT_VERSION=1.1.0

### TEMPLATE NOTES ###
## RUN Commands need to be completely self contained. Each RUN block
## is a single layer, if you download a file in one RUN then in another
## RUN you chmod/edit/etc.. anything to that file, you double the size
## of that file as it's copied in 2 layers in a single image
###
RUN apk add --update --no-cache \
  curl \
  bash

### TEMPLATE NOTES ###
## There should always be a entrypoint for a container that's used for
## applications docker_entrypoint.sh or entrypoint.sh scripts are common for
## complex setups. Some just use a single command and CMD is used for args
###
ENTRYPOINT [ "curl" ]

### TEMPLATE NOTES ###
## Have a default command so the container can just be ran
###
CMD ["https://asciitv.fr"]

FROM docker.io/library/golang:1.17.6-alpine3.15

# azure-pipelines-agent https://github.com/microsoft/azure-pipelines-agent/blob/master/docs/design/non-glibc-containers.md

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/bin/node"

RUN apk add --no-cache bash git nodejs npm make sudo shadow py3-pip gcc musl-dev python3-dev libffi-dev openssl-dev cargo

# conftest: https://www.conftest.dev/install/
ARG CONFTEST_VERSION
ENV CONFTEST_VERSION=${CONFTEST_VERSION:-0.25.0}
RUN set -ex; \
    apk add --no-cache --virtual .build build-base curl; \
    curl -fsSLo conftest.tar.gz "https://github.com/open-policy-agent/conftest/releases/download/v$CONFTEST_VERSION/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz"; \
    tar -xf conftest.tar.gz; \
    mv conftest /usr/local/bin; \
    rm conftest.tar.gz; \
    apk del --no-network .build

# opa: https://www.openpolicyagent.org/docs/latest/#1-download-opa
ARG OPA_VERSION
ENV OPA_VERSION=${OPA_VERSION:-0.37.1}
RUN set -ex; \
    apk add --no-cache --virtual .build curl; \
    curl -fsSLo opa "https://openpolicyagent.org/downloads/v$OPA_VERSION/opa_linux_amd64_static"; \
    chmod +x opa; \
    mv opa /usr/local/bin; \
    apk del --no-network .build

# repo: https://gerrit.googlesource.com/git-repo/#install
RUN set -ex; \
    apk add --no-cache openssh python3; \
    ln -sf python3 /usr/bin/python; \
    apk add --no-cache --virtual .build curl; \
    curl -fsSLo repo https://storage.googleapis.com/git-repo-downloads/repo; \
    chmod a+rx repo; \
    mv repo /usr/local/bin; \
    apk del --no-network .build

# terraform: https://learn.hashicorp.com/tutorials/terraform/install-cli
ARG TERRAFORM_VERSION
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION:-1.1.7}
RUN set -ex; \
    apk add --no-cache --virtual .build curl; \
    curl -fsSLo terraform.zip "https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"; \
    unzip terraform.zip; \
    mv terraform /usr/local/bin; \
    rm terraform.zip; \
    apk del --no-network .build

# tflint: https://github.com/terraform-linters/tflint#installation
ARG TFLINT_VERSION
ENV TFLINT_VERSION=${TFLINT_VERSION:-0.34.1}
RUN set -ex; \
    apk add --no-cache --virtual .build curl; \
    curl -fsSLo tflint.zip "https://github.com/terraform-linters/tflint/releases/download/v$TFLINT_VERSION/tflint_linux_amd64.zip"; \
    unzip tflint.zip; \
    mv tflint /usr/local/bin; \
    rm -rf tflint.zip; \
    apk del --no-network .build

#semantic-release: https://github.com/semantic-release/github
RUN npm -g install @semantic-release/git semantic-release; \
    npm cache clean --force

#AzureCLI: https://github.com/Azure/azure-cli/issues/19591
RUN pip install --no-cache-dir --upgrade pip; \
    pip install --no-cache-dir azure-cli

# golangci-lint
ARG GOLANGCI_LINT_VERSION
ENV GOLANGCI_LINT_VERSION=${GOLANGCI_LINT_VERSION:-1.45.2}
RUN set -ex; \
    apk add --no-cache --virtual .build curl; \
    curl -fsSLo golangci-lint.tar.gz "https://github.com/golangci/golangci-lint/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-arm64.tar.gz"; \
    tar -xzf golangci-lint.tar.gz; \
    mv golangci-lint-*/golangci-lint /usr/local/bin; \
    rm -rf golangci-lint*; \
    apk del --no-network .build

RUN mkdir /app
WORKDIR /app
