FROM caddy:2-builder-alpine AS builder

ARG VERSION

RUN xcaddy build v${VERSION} \
    --with github.com/caddy-dns/tencentcloud \
    --with github.com/caddyserver/replace-response \
    --with github.com/mholt/caddy-l4

FROM caddy:2-alpine

RUN apk add --no-cache tzdata

ENV TZ=Asia/Shanghai
RUN ln -nsf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
