FROM alpine:3

### TEMPLATE NOTES ###
## ARGS/ENV Should be set at the top for quick reference especially if they
## affect the RUN layers below
###
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

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
