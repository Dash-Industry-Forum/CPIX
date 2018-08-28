$ErrorActionPreference = "Stop"

# Ensure that prerequisites exist.
if (!(Get-Command -Name "java")) {
    Write-Error "Java must be installed and the binaries available via the PATH variable."
}

$graphviz = Join-Path $PSScriptRoot "graphviz"

if (!(Test-Path $graphviz)) {
    Write-Error "The tooling does not appear to be installed. Execute Install-Tooling.ps1 first!"
}