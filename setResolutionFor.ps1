param($target)
Write-Output "Target: $target"

$scaling = 0
$2kWidth = 2560
$2kHeight = 1440
$4kWidth = 3840
$4kHeight = 2160

if ($target -match "splashtop") {
    $scaling = 2
    $2kWidth = 1920
    $2kHeight = 1250
    $4kWidth = 2490
    $4kHeight = 1620
}

Push-Location $PSScriptRoot

foreach ($i in 1..3) {
    # https://github.com/RickStrahl/SetResolution
    $output = SetResolution LIST -m $i 2>$null
    if ($output -match "3840 x 2160")
    {
        Write-Output "Monitor $i is 4K"
        Write-Output "SetResolution SET -w $4kWidth -h $4kHeight -f 60 -m $i -noprompt"
        SetResolution SET -w $4kWidth -h $4kHeight -f 60 -m $i -noprompt
    }
    elseif ($output -match "2560 x 1440")
    {
        Write-Output "Monitor $i is 2K"
        Write-Output "SetResolution SET -w $2kWidth -h $2kHeight -f 165 -m $i -noprompt"
        SetResolution SET -w $2kWidth -h $2kHeight -f 165 -m $i -noprompt
    } else {
        Write-Output "No monitor $i"
    }
}

import-module .\powershell_modules\set-scaling.psm1

Write-Output "Setting scaling to $scaling"
Set-Scaling -scaling $scaling

Pop-Location
