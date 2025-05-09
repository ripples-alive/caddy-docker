#!/bin/sh

NAME=caddy
BUILDER=${NAME}-builder

docker pull caddy:2-builder-alpine

docker buildx create --use --name $BUILDER
docker buildx inspect --bootstrap

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --push \
    --pull \
    --tag ripples/$NAME \
    --builder $BUILDER .

docker buildx stop $BUILDER
docker buildx rm $BUILDER
