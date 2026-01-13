#!/usr/bin/env bash
set -euo pipefail

# Target OSes and architectures
# oses=("linux" "windows" "darwin" "freebsd")
# arches=("amd64" "arm64")
oses=("linux" "windows")
arches=("amd64")


# Ensure embed directories exist
for os in "${oses[@]}"; do
  for arch in "${arches[@]}"; do
    mkdir -p "embed/${os}_${arch}"
  done
done

# Build precommit binary for each OS/ARCH
for os in "${oses[@]}"; do
  for arch in "${arches[@]}"; do
    echo "Building precommit for ${os}/${arch}"

    output="embed/${os}_${arch}/precommit"
    if [[ "$os" == "windows" ]]; then
      output="${output}.exe"
    fi

    GOOS="$os" GOARCH="$arch" \
      go build -o "$output" ./partial_builds/precommit/main.go

    ls -lh "embed/${os}_${arch}/"
  done
done
