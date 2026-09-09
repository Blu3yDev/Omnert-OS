# Publishing OmnertOS

GitHub Actions builds the live ISO on every push to `main`, every pull request,
and every version tag. Ordinary workflow runs retain a downloadable build
artifact for 14 days.

## First push

1. Create an empty GitHub repository.
2. Commit this project and push it to the repository's `main` branch.
3. Open the repository's **Actions** tab.
4. Select **Build OmnertOS ISO** and wait for the build to finish.
5. Download the workflow artifact and test it in QEMU before publishing it.

## Publish a prerelease

After the image has been tested, create and push a version tag:

```bash
git tag v0.1.0-alpha.1
git push origin v0.1.0-alpha.1
```

The tagged workflow creates a GitHub prerelease containing:

```text
omnertos-x86_64.iso
omnertos-x86_64.iso.sha256
```

Releases remain marked as prereleases intentionally while OmnertOS is live-only
and has not completed its hardware test matrix.

## Verify a download

Linux users can verify that the downloaded file matches the published checksum:

```bash
sha256sum --check omnertos-x86_64.iso.sha256
```

The checksum detects an incomplete or altered download. It is not yet a digital
signature proving who produced the release. Signed releases should be added
before OmnertOS is presented as production-ready.

## Current release limitations

- The image supports live boot only; it does not install to a computer.
- Secure Boot has not been configured or validated.
- Hardware compatibility has not been established outside tested machines.
- Persistence across live-session reboots is not configured.
- The automatic `omnert` login is intended only for the live prototype.

Do not tell users to overwrite a system disk. The Phase 6 installer must provide
explicit disk selection, partition review, and a final destructive-action
warning before installed use is supported.

