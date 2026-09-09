[CmdletBinding()]
param(
    [ValidateRange(1024, 32768)]
    [int] $MemoryMb = 2048,

    [ValidateRange(1, 32)]
    [int] $CpuCount = 2,

    [switch] $HardwareAcceleration
)

$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$isoPath = Join-Path $projectRoot 'build\omnertos-x86_64.iso'

if (-not (Test-Path -LiteralPath $isoPath -PathType Leaf)) {
    throw @"
ISO not found at:
  $isoPath

Download the GitHub Actions artifact, extract it, and place
omnertos-x86_64.iso in the build directory.
"@
}

$qemuCommand = Get-Command 'qemu-system-x86_64.exe' -ErrorAction SilentlyContinue
$qemuPath = if ($qemuCommand) {
    $qemuCommand.Source
} else {
    'C:\Program Files\qemu\qemu-system-x86_64.exe'
}

if (-not (Test-Path -LiteralPath $qemuPath -PathType Leaf)) {
    throw @"
QEMU was not found. Install it with:
  winget install --exact --id SoftwareFreedomConservancy.QEMU

Restart PowerShell after installation, then run this script again.
"@
}

Write-Host 'Starting OmnertOS in a temporary, diskless virtual machine...'
Write-Host 'Close the QEMU window to stop it.'

$acceleratorArguments = if ($HardwareAcceleration) {
    @('-accel', 'whpx')
} else {
    @()
}

& $qemuPath `
    -name 'OmnertOS Live' `
    @acceleratorArguments `
    -machine q35 `
    -m $MemoryMb `
    -smp $CpuCount `
    -device virtio-vga `
    -display sdl `
    -nic 'user,model=virtio-net-pci' `
    -device qemu-xhci `
    -device usb-tablet `
    -boot d `
    -cdrom $isoPath

if ($LASTEXITCODE -ne 0) {
    throw "QEMU exited with code $LASTEXITCODE."
}
