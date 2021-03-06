#!/bin/bash

[ -z "$PROTOS_FRONTEND_PATH" ] && echo "Please set environment variable PROTOS_FRONTEND_PATH" && exit 1;

docker network create protosnet &> /dev/null

docker run \
       --rm \
       -ti \
       --privileged \
       -v "$PWD":/go/src/github.com/nustiueudinastea/protos \
       -v /opt/protos:/opt/protos \
       -v "$PROTOS_FRONTEND_PATH":/protosfrontend \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -w /go/src/github.com/nustiueudinastea/protos \
       -p 8080:8080 \
       -p 8443:8443 \
       --name protos \
       --hostname protos \
       --network protosnet \
       golang:1.9.4 \
       go run cmd/protos/protos.go --loglevel debug --config protos.dev.yaml daemon
