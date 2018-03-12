$ErrorActionPreference = "Stop"

# Ensure that prerequisites exist.
if (!(Get-Command -Name "java")) {
    Write-Error "Java must be installed and the binaries available via the PATH variable."
}

# Install (=unpack) any tooling components that are not usable as-is.
# They will be installed into subdirectories of the tooling directory.

# Unpack Graphviz. It is in a zip for easy packaging - all we need to do is unpack it.
$graphvizSource = Join-Path $PSScriptRoot "graphviz-win64.zip"
$graphvizDestination = Join-Path $PSScriptRoot "graphviz"

if (Test-Path $graphvizDestination) {
    # Remove any old version.
    Remove-Item -Recurse -Force -Path $graphvizDestination
}

Expand-Archive -Path $graphvizSource -DestinationPath $graphvizDestination

# Validate that PlantUML can use the installed Graphviz dot.exe without issues.
$plantuml = Join-Path $PSScriptRoot "plantuml.jar"
$graphvizdot = Join-Path $graphvizDestination "dot.exe"

$stdout = java -jar "$plantuml" -graphvizdot "$graphvizdot" -testdot

if ($stdout -match "Error: *") {
    $stdout | Out-Host
    Write-Error "Graphviz setup failed - PlantUML was unable to execute Graphviz!"
}