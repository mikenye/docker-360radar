#!/usr/bin/env sh
#shellcheck shell=sh

REPO=mikenye
IMAGE=360radar
PLATFORMS="linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64"

docker context use x86_64
export DOCKER_CLI_EXPERIMENTAL="enabled"
docker buildx use homecluster

# Build latest image using buildx
docker buildx build -t "${REPO}/${IMAGE}:latest" --no-cache --compress --push --platform "${PLATFORMS}" .

# Get latest version
VERSION=$(docker run --rm --entrypoint cat "${REPO}/${IMAGE}:latest" /VERSIONS | grep mlat-client | cut -d " " -f 2 | tr -d " ")

# Build version specific using buildx
docker buildx build -t "${REPO}/${IMAGE}:${VERSION}" --compress --push --platform "${PLATFORMS}" .
