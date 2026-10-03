# caddy-docker

Custom Caddy image with commonly used plugins prebuilt for deployment.

## Image

- Registry: `ghcr.io/ripples-alive/caddy`
- Version tag: `ghcr.io/ripples-alive/caddy:2.11.6`
- Latest tag: `ghcr.io/ripples-alive/caddy:latest`
- Platforms: `linux/amd64`, `linux/arm64`

## Included plugins

- `github.com/caddy-dns/cloudflare`
- `github.com/caddy-dns/tencentcloud`
- `github.com/caddyserver/replace-response`
- `github.com/mholt/caddy-l4`

The image is based on the official `caddy:2-alpine` runtime image, adds `tzdata`, sets `TZ=Asia/Shanghai`, and replaces `/usr/bin/caddy` with an `xcaddy` build for the pinned upstream Caddy version.

## GitHub Actions build

`.github/workflows/docker-image.yml` builds the image with Docker Buildx.

- Pull requests: build only, no registry push.
- Pushes to `main`: build and push the pinned version plus `latest`.
- Tags matching `v*`: build the tag version and push it plus `latest`.
- Manual dispatch: optionally override the Caddy version and whether to push.

The pinned upstream version is stored in `caddy-version.txt`:

```text
2.11.6
```

The `Update Caddy stable release` workflow checks the upstream stable release
every day, validates a candidate multi-architecture build, and opens an exact
version PR for automatic merging when repository rules allow it. Automated
version commits avoid workflow files so the built-in `GITHUB_TOKEN` can push
them.

## Local legacy build

`build.sh` remains available for manual Docker Hub-style builds:

```bash
./build.sh
```

For normal maintenance, prefer the GitHub Actions workflow and GHCR image above.
