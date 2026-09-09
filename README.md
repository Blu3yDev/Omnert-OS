# OmnertOS

OmnertOS is a lightweight Linux desktop focused on a clean everyday experience.
The current repository implements the **Phase 1 bootable prototype**: a Debian
Live ISO that starts a minimal Wayland desktop with working input, networking,
audio, and a terminal.

## Current stack

- Debian 13 (Trixie) live base
- Linux kernel and Debian hardware support
- Labwc Wayland compositor
- Waybar panel
- Foot terminal
- NetworkManager (with a tray applet)
- PipeWire and WirePlumber audio

The live session logs in as `omnert` without a password. This convenience is
limited to the non-persistent live image and is not an installer design.

## Build the ISO

Building requires a Debian or Ubuntu Linux environment with `live-build`,
`debootstrap`, `xorriso`, and root access. On Windows, use WSL 2 with Debian or
Ubuntu and keep the repository inside the WSL filesystem for substantially
faster builds.

```bash
sudo apt update
sudo apt install live-build debootstrap xorriso squashfs-tools isolinux syslinux-common
sudo bash ./scripts/build-iso.sh
```

The resulting image is written to:

```text
build/omnertos-x86_64.iso
```

Run the fast image-definition checks on any host with Python 3.11 or newer:

```bash
python tests/validate.py
```

Build in a container instead when Docker or Podman is available:

```bash
bash ./scripts/build-container.sh
```

## Run in QEMU

```bash
bash ./scripts/run-qemu.sh
```

The QEMU helper is intentionally non-destructive: it only attaches the ISO as
read-only installation media and creates no virtual disk.

## Desktop controls

- `Super + Enter`: open a terminal
- `Super + D`: open the application launcher
- `Super + Q`: close the active window
- `Super + Shift + E`: exit the live desktop session

See [docs/architecture.md](docs/architecture.md) for design boundaries and
[docs/build.md](docs/build.md) for build and troubleshooting details.

## Build and publish with GitHub

The included GitHub Actions workflow validates and builds the ISO on pushes and
pull requests. A tag beginning with `v` publishes the ISO and checksum as a
GitHub prerelease:

```bash
git tag v0.1.0-alpha.1
git push origin v0.1.0-alpha.1
```

Read [docs/releasing.md](docs/releasing.md) before publishing. The current image
is a live boot prototype, not an installable operating-system release. A safe
graphical disk installer, Secure Boot work, and broader hardware testing remain
future phases.

## Status

Phase 1 is implemented as a buildable live-image definition. Hardware and VM
validation remain explicit release steps; no hardware compatibility is assumed
until it has been measured on the target device. Disk installation is not yet
implemented.
