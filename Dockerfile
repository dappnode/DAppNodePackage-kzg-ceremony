FROM golang:alpine3.17 as build

WORKDIR /usr/src/app

RUN apk add -u git build-base curl jq bash

RUN git clone https://github.com/jsign/go-kzg-ceremony-client.git && \
    cd go-kzg-ceremony-client && \
    make build

RUN ls -lrt 

FROM alpine:3.17

RUN apk add -u bash curl jq

COPY --from=build /usr/src/app/go-kzg-ceremony-client/kzgcli /usr/local/bin
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]