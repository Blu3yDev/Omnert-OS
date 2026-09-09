#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
container_engine=""

for candidate in podman docker; do
  if command -v "${candidate}" >/dev/null 2>&1; then
    container_engine="${candidate}"
    break
  fi
done

if [[ -z "${container_engine}" ]]; then
  echo "Docker or Podman is required." >&2
  exit 1
fi

"${container_engine}" build -t omnertos-builder -f "${project_root}/distro/Containerfile" "${project_root}"
"${container_engine}" run --rm --privileged \
  -v "${project_root}:/workspace" \
  omnertos-builder

