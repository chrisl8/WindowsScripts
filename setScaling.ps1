param($scaling)

$scalingInteger = 0

# $scaling = 0 : 100% (default)
# $scaling = 1 : 125%
# $scaling = 2 : 150%
# $scaling = 3 : 175%

if ($scaling -match 100)
{
    $scalingInteger = 0
}
elseif ($scaling -match 125)
{
    $scalingInteger = 1
}
elseif ($scaling -match 150)
{
    $scalingInteger = 2
}
elseif ($scaling -match 175)
{
    $scalingInteger = 3
}
else
{
    Write-Output "Unknown scaling: $scaling"
    exit
}

Push-Location $PSScriptRoot

import-module .\powershell_modules\set-scaling.psm1

Write-Output "Setting scaling to $scaling"
Set-Scaling -scaling $scalingInteger

Pop-Location
