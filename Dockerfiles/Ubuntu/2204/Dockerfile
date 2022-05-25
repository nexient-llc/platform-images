FROM ubuntu:22.04

ARG CONFTEST_VERSION=0.25.0
ARG OPA_VERSION=0.37.1
ARG TERRAFORM_VERSION=1.1.7
ARG TFLINT_VERSION=0.34.1
ARG SBOT_VERSION=1.1.0

# Do full OS setup including all package installs that can be done with tools
# Packages are alphabetized for easy consumption
RUN apt-get update \
  && apt-get upgrade --yes \
  && apt-get install --yes --no-install-recommends --reinstall \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
      lsb-release \
  && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get update \
  && apt-get install --yes --no-install-recommends \
      build-essential \
      git \
      nodejs \
      openssh-server \
      python3-pip \
      unzip \
  && mkdir /app \
  && cd /app \
  && pip install --no-cache-dir --upgrade pip \
  && npm install --global @semantic-release/git semantic-release \
  && npm cache clean --force \
  && ln -sf /usr/bin/python3 /usr/bin/python \
  && pip install --no-cache-dir pre-commit \
  && pip install --no-cache-dir --upgrade azure-cli \
  && az extension add --name azure-devops \
  && curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null \
  && AZ_REPO=$(lsb_release -cs) \
  && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list \
  && apt-get update \
  && apt-get install --no-install-recommends --reinstall azure-cli \
  && set -ex \
  && curl -fsSLo conftest.tar.gz "https://github.com/open-policy-agent/conftest/releases/download/v$CONFTEST_VERSION/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz" \
  && tar -xf conftest.tar.gz \
  && mv conftest /usr/local/bin \
  && rm conftest.tar.gz \
  && curl -fsSLo opa "https://openpolicyagent.org/downloads/v$OPA_VERSION/opa_linux_amd64_static" \
  && chmod +x opa \
  && mv opa /usr/local/bin \
  && apt-get install --yes --no-install-recommends --reinstall repo \
  && curl -fsSLo terraform.zip "https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
  && unzip terraform.zip \
  && mv terraform /usr/local/bin \
  && rm terraform.zip \
  && curl -fsSLo tflint.zip "https://github.com/terraform-linters/tflint/releases/download/v$TFLINT_VERSION/tflint_linux_amd64.zip" \
  && unzip tflint.zip \
  && mv tflint /usr/local/bin \
  && rm -rf tflint.zip \
  && curl -fsSLo sbot "https://github.com/restechnica/semverbot/releases/download/v$SBOT_VERSION/sbot-linux-amd64" \
  && chmod +x sbot \
  && mv sbot /usr/local/bin \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /app/* \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

WORKDIR /app