param(
    # If provided, will ignore errors and produce whatever output can be produced.
    [Parameter()]
    [switch]$force
)

$ErrorActionPreference = "Stop"

. $PSScriptRoot/Functions.ps1

# Any *.bs file in the input will be transformed into *.html in the output.
$inputPath = Split-Path -Parent $PSScriptRoot
$outputDirectoryPath = Join-Path (Split-Path -Parent $PSScriptRoot) "Output"

# Clean existing .html files.
Get-ChildItem -Path $outputDirectoryPath -Filter "*.html" | Remove-Item

Get-ChildItem -Path $inputPath -Filter "*.bs" | ForEach-Object {
    $outputPath = Join-Path $outputDirectoryPath ($_.BaseName + ".html")

    Write-Host "Building $($_.FullName)"

    if ($force) {
        [Bikeshed]::Compile($_.FullName, $true) | Out-File $outputPath
    }
    else {
        [Bikeshed]::Compile($_.FullName, $false) | Out-File $outputPath
    }
}