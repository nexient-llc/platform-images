# Container Image Template <!-- omit in toc -->

<INSERT DESCRIPTION>

## Table Of Contents <!-- omit in toc -->
Can be automanaged by [Markdown All in One](https://github.com/yzhang-gh/vscode-markdown) by Yu Zhang
- [How to Use This Template](#how-to-use-this-template)
  - [Using Different Registries](#using-different-registries)
  - [Ignore Files](#ignore-files)
- [Quick Reference](#quick-reference)
- [Tagged Dockerfiles](#tagged-dockerfiles)
- [Usage](#usage)
  - [Makefile](#makefile)
    - [Target List](#target-list)
  - [Quick Run](#quick-run)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
  - [Can't Close Container When Running Interactively](#cant-close-container-when-running-interactively)
- [Repo Documentation](#repo-documentation)
  - [Build Locally](#build-locally)
    - [Prerequisites](#prerequisites)
    - [Login](#login)
    - [Build](#build)
    - [Test](#test)
    - [Push](#push)
    - [Publish](#publish)
  - [Contributing](#contributing)
    - [External Contributors](#external-contributors)
    - [Internal Contributors](#internal-contributors)
  - [Release A New Version](#release-a-new-version)


<TEMPLATE ONLY, REMOVE IN GENERATED REPO - START>

## How to Use This Template

This template is just a best practice layout for docker images and building/pushing them to Docker Hub. This can be used for any container and registry service, however the github workflows and examples are geared towards Docker and Docker Hub as default.

- Repo
  - Generate a New Repo based on this template [Click Here](https://github.com/nexient-llc/container-template/generate) or use the "Use this template" button
  - Note all the comments in `<>` in the README for information to add/change, remove all `<>` when finished
  - [test.yaml](test.yaml) is for the [Container Structure Test](https://github.com/GoogleContainerTools/container-structure-test)
  - Dockerfiles are stored in [Dockerfiles](Dockerfiles/) and separated by OS/Version
  - Github Workflows cover doing two different OS's, with Alpine being treated as default
    - Image Name in github workflows will need to match the repo created in next section
- Docker
  - Create a new Docker Hub Repo [Click Here](https://hub.docker.com/repositories)
  - Select where you want to create the repo from the dropdown
  - Enter the information and click create
  - Once Created, click settings and enable Vulnerability Scanning

### Using Different Registries
If using another supported registry other than Dockerhub (the default for the template), you will need to change the `REGISTRY` default in the `Makefile` or set `export REGISTRY='ecr'` or add `REGISTRY='ecr` to each make command.

### Ignore Files
Double check the `.gitignore` and `.dockerignore` files to ensure there is nothing in your project that you want in git/docker that may be ignored by default. The files in the template repo are just large default/recommended ignores for multiple languages/os.

<TEMPLATE ONLY, REMOVE IN GENERATED REPO - END>

## Quick Reference

<Provide Fully Qualified Links here>

- Repo
- [File An Issue](https://github.com/nexient-llc/container-template/issues/new/choose)
- [Documentation](#table-of-contents)

## Tagged Dockerfiles

<Change to direct links to specific releases/tags and fully qualified URLs>

 - [latest](Dockerfiles/Alpine/3/Dockerfile)
 - [0.0.1](Dockerfiles/Alpine/3/Dockerfile)
 - [0.0.1-ubuntu](Dockerfiles/Ubuntu/2204/Dockerfile)
 - [0.0.1-alpine](Dockerfiles/Alpine/3/Dockerfile)

## Usage

### Makefile
We provide a Makefile to simplify/assits in local development, though it is not required.

#### Target List
This is just the list of available Make Targets/Commands, more specifics in using them are in the [Build Locally](#build-locally) section

- `make login` - Logs into container registry (currently supported, Dockerhub, AWS ECR, Azure ACR)
- `make build` - Builds the image
- `make check` - Runs tests against the image
- `make run` - Runs the image
- `make tag` - Tags the image in a standard way to be used in a registry
- `make push` - Pushes to the provided registry
- `make publish` - Runs build & push

<Add ways to run image, cover several common use cases>

### Quick Run
- Standard Command
  ```
  docker run -it --rm nexientdevops/container-template
  ```
- Make
  ```
  make run
  ```

## Configuration

<If any, place config here>

## Troubleshooting

<Add known issues and solutions>

### Can't Close Container When Running Interactively
- May have to close terminal, then run `docker stop` on the container

## Repo Documentation

<In-Depth Documentation and local build info>

### Build Locally

#### Prerequisites
- [Docker](https://docs.docker.com/get-docker/)
- [Container Structure Test](https://github.com/GoogleContainerTools/container-structure-test)
- Optional: [Make](https://www.gnu.org/software/make/)

#### Login
Login to a registry
- Dockerhub
  ```
  make login
  ```
- AWS ECR
  ```
  make login REGISTRY='ecr'
  ```
- Azure ACR
  ```
  make login REGISTRY='acr'
  ```
#### Build
Build the image
- Alpine
  - Standard
    ```
    docker build --tag "nexientdevops/container-template:dev" --file "./Dockerfiles/Alpine/3/Dockerfile"
    ```
  - Make
    ```
    make build
    ```
- Ubuntu
  - Standard
    ```
    docker build --tag "nexientdevops/container-template:dev" --file "./Dockerfiles/Ubuntu/2204/Dockerfile"
    ```
  - Make
    ```
    make build FILE="./Dockerfiles/Ubuntu/2204/Dockerfile"
    ```

#### Test
Run container structure test on Image
- Standard
  ```
    container-structure-test test --image nexientdevops/container-template:dev --config tests.yaml
  ```
- Make
  ```
  make check
  ```

#### Push
Tag and Push Image to Registry
- Standard
  ```
    docker push nexientdevops/container-template:dev
  ```
- Make
  ```
  make push
  ```

#### Publish
This will run both `build` and `push` commands
  ```
  make publish
  ```

### Contributing

#### External Contributors

-   Fork the repo on GitHub
-   Clone the project to your own machine
-   Commit changes to your own branch
-   Push your work back up to your fork
-   Submit a Pull Request so that we can review your changes

**NOTE**: Be sure to pull & merge the latest from "upstream" before making a pull request!

#### Internal Contributors

-   Clone the project to your own machine
-   Create a new branch from main
-   Commit changes to your own branch
-   Push your work back up to your branch
-   Submit a Pull Request so the changes can be reviewed

**NOTE**: Be sure to pull & merge the latest from "upstream" before making a pull request!

### Release A New Version
```
git checkout 0.0.1
git checkout -b 0.0.2
git commit -am "Container 0.0.2 release"
git tag -a 0.0.2 -m "Release 0.0.2"
git push origin 0.0.2
```