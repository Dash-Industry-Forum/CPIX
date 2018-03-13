$ErrorActionPreference = "Stop"

# Creates a clean Output directory containing only the static files.
Write-Host "Creating clean Output directory."

$staticFilesPath = Join-Path (Split-Path -Parent $PSScriptRoot) "StaticFiles"
$outputDirectoryPath = Join-Path (Split-Path -Parent $PSScriptRoot) "Output"

if (Test-Path $outputDirectoryPath) {
    # Do not delete the directory itself, just contents.
    # This avoids some file locking issues.
    Get-ChildItem -Path $outputDirectoryPath | Remove-Item -Force -Recurse
}

[IO.Directory]::CreateDirectory($outputDirectoryPath) | Out-Null

Get-ChildItem $staticFilesPath | % { Copy-Item -Path $_.FullName $outputDirectoryPath -Recurse }