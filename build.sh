#!/bin/sh

BUILDER=caddy-builder

docker pull caddy:2-builder-alpine

docker buildx create --use --name $BUILDER
docker buildx inspect --bootstrap

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --output "type=image,push=true" \
    --tag ripples/caddy \
    --builder $BUILDER .

docker buildx stop $BUILDER
docker buildx rm $BUILDER
