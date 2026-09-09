#!/usr/bin/env python3
"""Fast, host-independent checks for the OmnertOS image definition."""

from __future__ import annotations

import json
import tomllib
import xml.etree.ElementTree as ET
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
OVERLAY = ROOT / "distro/config/includes.chroot"


def read(relative_path: str) -> str:
    return (ROOT / relative_path).read_text(encoding="utf-8")


def main() -> None:
    config = read("distro/auto/config")
    assert "--distribution trixie" in config
    assert "--binary-images iso-hybrid" in config
    assert "--debian-installer none" in config
    assert "username=omnert" in config

    clean = read("distro/auto/clean")
    assert "lb clean noauto --purge" in clean

    build_script = read("scripts/build-iso.sh")
    assert "sha256sum omnertos-x86_64.iso > omnertos-x86_64.iso.sha256" in (
        build_script
    )
    assert 'sha256sum "${output_dir}/omnertos-x86_64.iso"' not in build_script

    package_lines = read(
        "distro/config/package-lists/omnertos.list.chroot"
    ).splitlines()
    packages = {
        line.strip()
        for line in package_lines
        if line.strip() and not line.lstrip().startswith("#")
    }
    required_packages = {
        "linux-image-amd64",
        "live-boot",
        "labwc",
        "waybar",
        "foot",
        "fuzzel",
        "greetd",
        "network-manager",
        "pipewire",
        "wireplumber",
        "mate-polkit",
    }
    assert required_packages <= packages
    assert len(packages) == len(
        [
            line.strip()
            for line in package_lines
            if line.strip() and not line.lstrip().startswith("#")
        ]
    ), "package list contains duplicates"
    assert "policykit-1-gnome" not in packages

    autostart = read(
        "distro/config/includes.chroot/etc/skel/.config/labwc/autostart"
    )
    assert "/usr/libexec/polkit-mate-authentication-agent-1" in autostart

    with (OVERLAY / "etc/greetd/config.toml").open("rb") as stream:
        greetd = tomllib.load(stream)
    assert greetd["initial_session"] == {
        "command": "/usr/local/bin/omnert-session",
        "user": "omnert",
    }

    with (
        OVERLAY / "etc/skel/.config/waybar/config"
    ).open(encoding="utf-8") as stream:
        waybar = json.load(stream)
    assert "custom/launcher" in waybar["modules-left"]
    assert "network" in waybar["modules-right"]

    labwc = ET.parse(
        OVERLAY / "etc/skel/.config/labwc/rc.xml"
    ).getroot()
    assert labwc.tag == "labwc_config"
    assert labwc.find("./keyboard/keybind/action/command") is not None

    wallpaper = ET.parse(
        OVERLAY / "usr/share/backgrounds/omnertos/default.svg"
    ).getroot()
    assert wallpaper.tag.endswith("svg")

    print("OmnertOS image definition checks passed.")


if __name__ == "__main__":
    main()
