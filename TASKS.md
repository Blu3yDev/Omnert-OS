# OmnertOS Task List

Status legend: `[x]` verified, `[~]` active, `[ ]` queued, `[!]` blocked.

## P0 — Keep every build real

- [x] Create Debian 13 hybrid live ISO definition.
- [x] Add static image-definition validation.
- [x] Build ISO in GitHub Actions.
- [x] Verify checksum outside the build container.
- [x] Boot the downloaded artifact in QEMU.
- [ ] Add automated BIOS boot-to-session test with a deterministic signal.
- [ ] Add UEFI VM boot validation.
- [ ] Record boot time, idle RAM, idle CPU, image size, and enabled services.

## Phase 2 — Omnert desktop identity

- [~] Install and document the supplied Omnert logo.
- [~] Establish shared color, type, radius, spacing, icon, and motion tokens.
- [~] Polish the panel layout and interactive states.
- [~] Add coherent symbolic icon coverage.
- [ ] Add graphical quick access for network, Bluetooth, audio, and display.
- [ ] Add a notification daemon with Omnert styling.
- [ ] Add a safe lock action and lock-screen styling.
- [ ] Add a power menu with lock, log out, restart, and shutdown.
- [ ] Add Omnert window-decoration theme.
- [ ] Add light and dark variants; dark remains the prototype default.
- [ ] Respect reduced-motion and high-contrast preferences where supported.
- [ ] Rebuild, boot, and capture the Phase 2 reference screenshot.

## Phase 3 — Core applications

- [ ] Specify the shared native application toolkit and packaging contract.
- [ ] Build Omnert Settings navigation and system-service adapters.
- [ ] Implement Wi-Fi, Bluetooth, display, audio, input, appearance, apps,
      storage, users, updates, power, and about settings pages.
- [ ] Build Omnert Files with safe copy, move, rename, trash, search, removable
      media, and Downloads behavior.
- [ ] Ship Foot as Omnert Terminal initially; add only valuable integration.
- [ ] Build Omnert Store over existing package/Flatpak infrastructure.
- [ ] Add graphical update progress, failure recovery, and restart guidance.
- [ ] Add accessibility and keyboard-navigation tests for every first-party app.

## Phase 4 — Daily-driver validation

- [ ] Wi-Fi and Ethernet matrix.
- [ ] Bluetooth audio/input/device matrix.
- [ ] PipeWire speakers, microphones, switching, and hot-plug matrix.
- [ ] Single, mirrored, extended, scaled, rotated, and hot-plugged displays.
- [ ] Keyboard layouts, compose, touchpad, mouse, and tablet basics.
- [ ] Battery, brightness, power profiles, lid close, suspend, and resume.
- [ ] Intel, AMD, and NVIDIA graphics matrix on disposable test machines.
- [ ] USB storage, cameras, controllers, NVMe, and SATA coverage.
- [ ] Recovery procedure for a failed update or broken graphical session.

## Phase 5 — Gaming

- [ ] Graphical Steam installation.
- [ ] Mesa, Vulkan, and 32-bit graphics validation.
- [ ] Proton setup and per-game compatibility messaging.
- [ ] Optional Wine integration without background-service cost.
- [ ] Controller hot-plug and mapping validation.
- [ ] NVIDIA proprietary-driver installation and rollback path.
- [ ] Publish honest anti-cheat and unsupported-game guidance.

## Phase 6 — Installer and release

- [ ] Threat-model partitioning, encryption, bootloader, and recovery flows.
- [ ] Select and integrate a maintained graphical installer.
- [ ] Implement language, keyboard, timezone, user, password, and disk pages.
- [ ] Require explicit confirmation before formatting or overwriting partitions.
- [ ] Test install/upgrade/reinstall on disposable BIOS and UEFI virtual disks.
- [ ] Test spare physical desktop and laptop hardware.
- [ ] Add Secure Boot signing and key-management procedure.
- [ ] Sign release ISO and checksum; document verification.
- [ ] Write privacy policy, security reporting policy, release notes, and support
      boundaries.
- [ ] Publish `omnertos-x86_64.iso` as an installable release only after every
      destructive-path and recovery test passes.

## Later, only if justified

- [ ] Persistent live USB mode.
- [ ] Omnert-owned panel/launcher replacing prototype components.
- [ ] ARM64 image after x86-64 release discipline is proven.
- [ ] Custom compositor only if measured product requirements cannot be met by
      maintained compositors.

