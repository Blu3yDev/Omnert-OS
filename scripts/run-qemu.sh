#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
iso_path="${project_root}/build/omnertos-x86_64.iso"

if [[ ! -f "${iso_path}" ]]; then
  echo "ISO not found: ${iso_path}" >&2
  echo "Build it first with sudo ./scripts/build-iso.sh" >&2
  exit 1
fi

if ! command -v qemu-system-x86_64 >/dev/null 2>&1; then
  echo "qemu-system-x86_64 is required." >&2
  exit 1
fi

accel_args=()
if [[ -w /dev/kvm ]]; then
  accel_args=(-enable-kvm -cpu host)
fi

exec qemu-system-x86_64 \
  "${accel_args[@]}" \
  -name OmnertOS \
  -m 2048 \
  -smp 2 \
  -device virtio-vga-gl \
  -display gtk,gl=on \
  -nic user,model=virtio-net-pci \
  -device qemu-xhci \
  -device usb-tablet \
  -cdrom "${iso_path}" \
  -boot d

