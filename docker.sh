#!/bin/bash
set -eux -o pipefail

readonly TAG=esp32-idf-build
readonly DIR=docker

main() {
  docker kill $(docker ps -q) || true
  docker build -t "${TAG}" "${DIR}"
  docker run -it \
    --device=/dev/ttyUSB0 \
    "${TAG}"
}

main "$@"
