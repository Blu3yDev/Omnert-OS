# Omnert visual tokens

These values are the shared visual contract for prototype shell components.
Toolkit-specific files may repeat the literal values until Omnert owns a shell
runtime capable of loading one token source.

## Color

| Token | Value | Use |
| --- | --- | --- |
| `canvas` | `#120f1a` | Desktop and lock-screen foundation |
| `surface` | `#17121f` | Menus, notifications, terminal |
| `surface-raised` | `#211b2d` | Tooltips and elevated controls |
| `text` | `#f7f4ff` | Primary text |
| `text-muted` | `#9e96ab` | Secondary text |
| `accent` | `#8b5cf6` | Focus and primary action |
| `accent-strong` | `#7651d6` | Selected controls |
| `accent-soft` | `#cbb5ff` | Icons and quiet emphasis |
| `warning` | `#f2c879` | Recoverable warning |
| `critical` | `#ff858f` | Error and critical battery |

## Geometry

| Token | Value |
| --- | ---: |
| Small control radius | 9 px |
| Standard control radius | 10 px |
| Elevated surface radius | 12 px |
| Launcher radius | 14 px |
| Panel height | 44 px |

## Type

- Interface: Inter, 10-13 px depending on density.
- Terminal and code: JetBrains Mono, 10.5 px default.
- Headings tighten tracking; small status text may add up to 0.2 px tracking.

## Motion

| Interaction | Duration | Purpose |
| --- | ---: | --- |
| Hover/color feedback | 120 ms | Immediate feedback |
| Press feedback | 100-160 ms | Immediate feedback |
| Small occasional surface | 180-240 ms | Spatial/state continuity |
| Lock-screen fade | 200 ms | Prevent a jarring transition |

Keyboard-launched surfaces remain instant. Animate transform and opacity only
when the toolkit supports them efficiently; do not add decorative loops.

