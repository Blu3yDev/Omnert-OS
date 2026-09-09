# Architecture

## System layers

```text
Applications
    ↓
Omnert session configuration and shell components
    ↓
Labwc (Wayland compositor)
    ↓
Debian userspace
    ↓
Linux kernel
    ↓
Hardware
```

The Phase 1 desktop deliberately composes mature components. OmnertOS owns the
session, defaults, visual language, package selection, and eventually the shell
and system applications. It does not own kernel drivers, the Wayland protocol,
network management, audio routing, or package resolution.

## Initial component choices

| Concern | Component | Reason |
| --- | --- | --- |
| Base | Debian 13 | Stable release with live-build support |
| Image construction | live-build | Native, inspectable Debian image pipeline |
| Compositor | Labwc | Lightweight wlroots compositor with simple configuration |
| Panel | Waybar | Proven Wayland panel suitable for the prototype |
| Launcher | Fuzzel | Small native Wayland application launcher |
| Terminal | Foot | Fast, lightweight native Wayland terminal |
| Networking | NetworkManager | Broad hardware support and existing graphical applet |
| Audio | PipeWire/WirePlumber | Current Linux desktop audio stack |
| Login | greetd | Small display/login manager with direct Wayland session support |

These are prototype dependencies, not permanent promises. Replacing a component
requires a measured user-experience or maintenance benefit.

## Safety boundary

The Phase 1 image is live-only. It contains no automatic partitioning, disk
formatting, or installation hook. A future installer must require explicit disk
selection and confirmation before any destructive operation.

## Repository boundaries

- `distro/`: reproducible image definition and root filesystem overlays
- `shell/`: future Omnert-owned shell components
- `apps/`: future first-party applications, kept independently buildable
- `installer/`: future graphical installer integration
- `themes/` and `assets/`: shared visual resources
- `scripts/`: developer build and VM helpers
- `tests/`: static and VM-level validation added with the relevant feature
- `docs/`: architecture decisions and operator documentation
