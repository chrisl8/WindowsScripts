Push-Location $PSScriptRoot

# https://github.com/RickStrahl/SetResolution
SetResolution SET -w 1920 -h 1250 -f 165 -noprompt

import-module .\powershell_modules\set-resolution.psm1

Set-Scaling -scaling 2

Pop-Location
