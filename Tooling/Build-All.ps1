param(
)

$ErrorActionPreference = "Stop"

& (Join-Path $PSScriptRoot "Clean-Output.ps1")
& (Join-Path $PSScriptRoot "Build-Diagrams.ps1")
& (Join-Path $PSScriptRoot "Build-Document.ps1")
& (Join-Path $PSScriptRoot "Build-Pdf.ps1")