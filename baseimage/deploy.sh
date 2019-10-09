#!/usr/bin/env bash
export BASE_DIR="$(dirname "$0")"
export RUST_VERSION=$(cat "${BASE_DIR}/rust.version")

docker build "${BASE_DIR}" \
	-t angelcam/rust-ci:latest \
	-t angelcam/rust-ci:${RUST_VERSION} \
	--build-arg "rust_version=${RUST_VERSION}"

docker push angelcam/rust-ci:latest
docker push angelcam/rust-ci:${RUST_VERSION}
