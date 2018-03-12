param(
    # If provided, will ignore warnings and produce whatever output can be produced.
    [Parameter()]
    [switch]$force
)

$ErrorActionPreference = "Stop"

. $PSScriptRoot/Functions.ps1

# Converts any .html file in the Output directory to .pdf.

$directoryPath = Join-Path (Split-Path -Parent $PSScriptRoot) "Output"

$htmlFiles = Get-ChildItem -Path $directoryPath -Filter "*.html"

if (!$htmlFiles) {
    Write-Error "No HTML files found! You must first execute Build-Document.ps1 to generate the HTML output."
}

$wkhtmltopdf = Join-Path $PSScriptRoot "wkhtmltopdf.exe"

$htmlFiles | ForEach-Object {
    $outputPath = Join-Path $directoryPath ($_.BaseName + ".pdf")

    Write-Host "Converting $($_.FullName)"

    # TODO: block access to unrelated files once a related defect is fixed
    # See https://github.com/wkhtmltopdf/wkhtmltopdf/issues/3846
    & $wkhtmltopdf --load-media-error-handling abort $_.FullName "$outputPath"

    if ($LASTEXITCODE -ne 0) {
        Write-Error "Conversion to PDF failed. See above log for errors."
    }
}