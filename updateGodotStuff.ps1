Push-Location $PSScriptRoot
updateGodotGameAddons.ps1
buildGodot.ps1
bash diffGodotGameStuff.sh
Pop-Location
Set-Location "C:\Dev\crater-manipulator"
git pull
Pop-Location
