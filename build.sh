#!/bin/sh

NAME=caddy
BUILDER="${NAME}-builder"
SCRIPT_DIR=$(CDPATH=; cd -- "$(dirname -- "$0")" && pwd)
VERSION=$(tr -d '\r\n' <"$SCRIPT_DIR/caddy-version.txt")

docker pull caddy:2-builder-alpine

docker buildx create --use --name "$BUILDER"
docker buildx inspect --bootstrap

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --push \
    --pull \
    --tag "ripples/${NAME}:${VERSION}" \
    --tag "ripples/${NAME}:latest" \
    --build-arg "VERSION=$VERSION" \
    --builder "$BUILDER" .

docker buildx stop "$BUILDER"
docker buildx rm "$BUILDER"
