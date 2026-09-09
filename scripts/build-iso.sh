#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
work_dir="${project_root}/.build-work"
output_dir="${project_root}/build"

if [[ "${EUID}" -ne 0 ]]; then
  echo "Build requires root because live-build creates device nodes and mounts filesystems." >&2
  echo "Run: sudo ./scripts/build-iso.sh" >&2
  exit 1
fi

for command_name in lb debootstrap xorriso mksquashfs rsync; do
  if ! command -v "${command_name}" >/dev/null 2>&1; then
    echo "Missing required build command: ${command_name}" >&2
    exit 1
  fi
done

mkdir -p "${work_dir}" "${output_dir}"
rsync -a --delete "${project_root}/distro/" "${work_dir}/"
chmod 0755 \
  "${work_dir}/auto/config" \
  "${work_dir}/auto/clean" \
  "${work_dir}"/config/hooks/live/*.hook.chroot

cd "${work_dir}"
lb clean --purge
lb config
lb build

iso_path="$(find . -maxdepth 1 -type f -name 'live-image-amd64.hybrid.iso' -print -quit)"
if [[ -z "${iso_path}" ]]; then
  echo "live-build completed without producing the expected ISO." >&2
  exit 1
fi

install -m 0644 "${iso_path}" "${output_dir}/omnertos-x86_64.iso"
sha256sum "${output_dir}/omnertos-x86_64.iso" > "${output_dir}/omnertos-x86_64.iso.sha256"
echo "Built ${output_dir}/omnertos-x86_64.iso"
