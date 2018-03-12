$ErrorActionPreference = "Stop"

# Creates a clean Output directory containing only the static files.

$staticFilesPath = Join-Path (Split-Path -Parent $PSScriptRoot) "StaticFiles"
$outputDirectoryPath = Join-Path (Split-Path -Parent $PSScriptRoot) "Output"

if (Test-Path $outputDirectoryPath) {
    Remove-Item -Force -Recurse -Path $outputDirectoryPath
}

Copy-Item $staticFilesPath $outputDirectoryPath -Recurse