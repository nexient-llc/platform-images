FROM alpine:3 as build

# RUN curl -LO https://storage.googleapis.com/container-structure-test/v1.11.0/container-structure-test-linux-amd64 \
#     && chmod +x container-structure-test-linux-amd64

RUN apk add --update --no-cache curl bash &&\
    curl -LO https://storage.googleapis.com/container-structure-test/v1.11.0/container-structure-test-linux-amd64 &&\
    mv container-structure-test-linux-amd64 container-structure-test &&\
    chmod +x container-structure-test

FROM gcr.io/distroless/static

COPY --from=build container-structure-test /usr/local/bin/container-structure-test
ENTRYPOINT ["/usr/local/bin/container-structure-test"]
