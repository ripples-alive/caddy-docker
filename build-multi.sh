#!/bin/sh

docker pull caddy:2-builder-alpine

docker buildx create --use --name mybuilder
docker buildx inspect --bootstrap

docker buildx build --platform linux/amd64,linux/arm64 --output "type=image,push=true" --tag ripples/caddy --builder mybuilder .

docker buildx stop mybuilder
docker buildx rm mybuilder
