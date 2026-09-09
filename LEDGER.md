# OmnertOS Engineering Ledger

Last updated: 2026-09-10

This document is the durable project memory. Update it whenever a milestone,
constraint, decision, measured result, or blocker changes. `TASKS.md` is the
execution queue; this ledger explains why the queue is ordered that way.

## Product promise

OmnertOS is a lightweight daily-driver Linux desktop that feels calm, direct,
and complete to somebody who has never used a terminal. It builds its identity
at the desktop and system-experience layer while reusing mature Linux hardware,
graphics, networking, audio, and package infrastructure.

The intended feeling is **quiet confidence**: deep violet, crisp type, precise
icons, soft depth, and motion that explains state without delaying work.

## Non-negotiables

- No ads, bundled promotions, or opt-out telemetry.
- No automatic destructive disk operations.
- No invented hardware or game compatibility claims.
- No terminal requirement for ordinary setup, updates, apps, or recovery.
- Every default process and dependency must justify its memory and startup cost.
- Frequent keyboard actions are instant. Motion is reserved for feedback,
  spatial continuity, and occasional state transitions.
- Reduced-motion and accessible contrast are release requirements.
- A green image build is not a release: the exact ISO must also boot and pass
  the relevant VM and hardware checklist.

## Current verified baseline

- Debian 13 Trixie live base.
- Hybrid x86-64 ISO produced by Debian live-build.
- BIOS QEMU boot verified on Windows on 2026-09-09.
- Labwc Wayland session reaches the desktop.
- Keyboard, pointer, Waybar, Fuzzel, Foot, and QEMU user-mode networking work.
- GitHub Actions run `34400546095` built and uploaded a verified ISO artifact.
- Verified ISO size: 1,066,401,792 bytes.
- Verified SHA-256:
  `EF9AFA2166EE444E175F25B4E7B9D630C87E08ABF000F858D5612785FD6F167D`.
- The live image is intentionally diskless and non-installable.

## Active milestone: Phase 2 shell identity

Completion means the next ISO visibly and functionally reads as OmnertOS:

1. Brand mark is installed as a first-class system asset.
2. Panel has coherent iconography, hierarchy, spacing, and useful click targets.
3. Launcher, terminal, notifications, lock, and power surfaces share one palette.
4. Network, Bluetooth, audio, lock, and power actions are reachable graphically.
5. Window decorations and first-party surfaces use the Omnert visual tokens.
6. Motion is restrained, compositor-friendly, and never added to keyboard paths.
7. The ISO builds, checksum-verifies, boots, and is visually inspected in QEMU.

## Architecture decisions

| Decision | Current choice | Revisit when |
| --- | --- | --- |
| Distribution base | Debian 13 Trixie | A supported successor is stable and migration-tested |
| Compositor | Labwc | Omnert shell requirements exceed Labwc protocols or performance |
| Prototype panel | Waybar | Omnert-owned panel reaches feature and accessibility parity |
| Prototype launcher | Fuzzel | Omnert-owned launcher has search, categories, and keyboard parity |
| Terminal engine | Foot | Only if an Omnert wrapper adds value without replacing emulation |
| Network service | NetworkManager | No planned replacement |
| Audio service | PipeWire + WirePlumber | No planned replacement |
| App delivery | Debian packages, then Flatpak | Store UX and trust model are specified |
| Installer | Undecided; evaluate Calamares | Phase 6 threat model and recovery design are complete |

## Visual system direction

- **Primary:** violet, derived from the supplied Omnert mark.
- **Neutrals:** blue-black rather than flat black; warm-white primary text.
- **Geometry:** 10-14 px surface radii, smaller 7-9 px control radii.
- **Depth:** one structural layer and one elevated layer; avoid stacks of glass.
- **Typography:** Inter for UI and JetBrains Mono for terminal/code where available.
- **Icons:** symbolic, optically aligned, and semantically specific. The Omnert mark
  is used for identity, never as a generic action icon.
- **Motion:** 120-160 ms press/hover feedback and 180-240 ms occasional surfaces,
  using transform/opacity where the toolkit supports it. No decorative loops.

## Performance budget

These are initial targets, not measurements. Record actual values per release.

| Metric | Alpha target | Latest measurement |
| --- | ---: | ---: |
| Cold boot to usable desktop | <= 15 s on reference SSD | Not measured |
| Idle RAM after settling | <= 700 MiB | Not measured |
| Idle CPU after settling | <= 1% average | Not measured |
| Compressed ISO size | <= 1.5 GiB | 1.017 GiB |
| Default background services | Audit every release | Not measured |
| Launcher visible after click | <= 120 ms | Not measured |

## Known limitations and risks

- No graphical installer or persistent live mode.
- No Secure Boot signing or verified UEFI test yet.
- No first-party Files, Settings, Store, or Terminal shell yet.
- No graphical update experience.
- NVIDIA proprietary drivers and gaming stack are not integrated.
- Hardware coverage is currently a single virtual-machine path.
- The current shell is a composition of prototype components, so some advanced
  animation and accessibility behavior is toolkit-limited.

## Release rule

Until the installer, recovery path, security review, update path, and physical
hardware matrix pass, releases remain clearly labeled **experimental live
prereleases**. “Installable” may only be used after destructive-path testing on
disposable disks.

