@echo off
set IMG=dashif/specs-builder:latest

rem Check if OPTS is defined, if not, set default value
if "%OPTS%"=="" (
    set OPTS=-ti
)

rem Collect command-line arguments
set TARGETS=%*

rem If no arguments are provided, use "spec"
if "%TARGETS%"=="" (
    set TARGETS=spec
)

rem Add parameters to TARGETS
set TARGETS=%TARGETS% SRC=Cpix.bs.md NAME=cpix

echo Running with targets: '%TARGETS%'
docker run --rm %OPTS% -v "%cd%:/data" -p 8000:8000 %IMG% %TARGETS%

