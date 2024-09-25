#!/bin/sh

docker pull caddy:2-builder-alpine
docker build . -t ripples/caddy
docker push ripples/caddy
