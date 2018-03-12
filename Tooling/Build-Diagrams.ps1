$ErrorActionPreference = "Stop"

& (Join-Path $PSScriptRoot "Verify-Install.ps1")

$inputPath = Join-Path (Split-Path -Parent $PSScriptRoot) "Diagrams"
$outputPath = Join-Path (Split-Path -Parent $PSScriptRoot) "Output"

[IO.Directory]::CreateDirectory($outputPath) | Out-Null

# Remove any existing diagram build output.
Get-ChildItem -Path $outputPath -Filter "*.png" | Remove-Item

# And build the diagrams anew.
$plantuml = Join-Path $PSScriptRoot "plantuml.jar"
$graphviz = Join-Path $PSScriptRoot "graphviz"
$graphvizdot = Join-Path $graphviz "dot.exe"

java -jar "$plantuml" -graphvizdot "$graphvizdot" -output "$outputPath" -timeout 60 "$inputPath\*.wsd"

if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed! See log above for errors."
}