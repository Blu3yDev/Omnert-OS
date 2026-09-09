# Build guide

## Supported build host

Use Debian 13, Ubuntu, or a compatible Linux container host. `live-build`
requires Linux filesystem features and root privileges, so native PowerShell is
not a supported image-building environment. WSL 2 works when systemd is enabled.

Required tools:

```bash
sudo apt update
sudo apt install live-build debootstrap xorriso squashfs-tools isolinux syslinux-common rsync
```

Then run:

```bash
sudo bash ./scripts/build-iso.sh
```

The build script copies `distro/` into `.build-work/`, keeping generated
live-build state out of the source definition. Re-running the command cleans
that generated state and creates `build/omnertos-x86_64.iso`.

## Container build

```bash
bash ./scripts/build-container.sh
```

The container needs privileged mode because live-build mounts pseudo-filesystems
and creates the bootable filesystem image. The repository is mounted only as the
workspace/output path.

## QEMU notes

Install QEMU and launch the live image:

```bash
sudo apt install qemu-system-x86
bash ./scripts/run-qemu.sh
```

The VM receives user-mode NAT networking, so wired connectivity should appear
automatically through NetworkManager. The helper uses 2 GiB RAM and two virtual
CPUs; these are test settings, not minimum system requirements.

### Windows

After downloading and extracting the GitHub Actions artifact, ensure the ISO is
located at `build/omnertos-x86_64.iso`. Install QEMU and start the diskless VM:

```powershell
winget install --exact --id SoftwareFreedomConservancy.QEMU
.\scripts\run-qemu.ps1
```

Restart PowerShell after installing QEMU so its command is discoverable. The
Windows helper also checks QEMU's default installation directory.

The launcher defaults to slower software emulation because it is the most
compatible Windows path. If Windows Hypervisor Platform is enabled and stable
on the machine, opt into acceleration:

```powershell
.\scripts\run-qemu.ps1 -HardwareAcceleration
```

The first desktop boot can take roughly two minutes under software emulation.

If virgl is unavailable, replace `-device virtio-vga-gl -display gtk,gl=on` in
the command with `-device virtio-vga -display gtk` for software rendering.

## Release validation checklist

Before publishing an image, manually verify:

1. BIOS and UEFI boot both reach the desktop.
2. Keyboard and pointer work in the launcher and terminal.
3. `Super + Enter` starts Foot.
4. NetworkManager obtains an address and reaches the internet.
5. Audio devices appear through PipeWire.
6. Logging out returns to a usable login/session path.
7. The ISO exposes no install or formatting action.
