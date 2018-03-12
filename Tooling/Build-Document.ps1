param(
    # If provided, will ignore errors and produce whatever output can be produced.
    [Parameter()]
    [switch]$force
)

$ErrorActionPreference = "Stop"

Write-Host "Compiling Bikeshed document to HTML."

. $PSScriptRoot/Functions.ps1

# Any *.bs file in the input will be transformed into *.html in the output.
$inputPath = Split-Path -Parent $PSScriptRoot
$outputDirectoryPath = Join-Path (Split-Path -Parent $PSScriptRoot) "Output"

Get-ChildItem -Path $inputPath -Filter "*.bs" | ForEach-Object {
    $outputPath = Join-Path $outputDirectoryPath ($_.BaseName + ".html")

    if ($force) {
        Write-Host "Building $($_.FullName)"
        [Bikeshed]::Compile($_.FullName, $true) | Out-File $outputPath
    }
    else {
        # First validate, because build only fails on super critical errors.
        Write-Host "Validating $($_.FullName)"
        [Bikeshed]::Validate($_.FullName)

        Write-Host "Building $($_.FullName)"
        [Bikeshed]::Compile($_.FullName, $false) | Out-File $outputPath
    }
}