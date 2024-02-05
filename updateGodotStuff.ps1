Push-Location $PSScriptRoot
updateGodotGameAddons.ps1
buildGodot.ps1
bash diffGodotGameStuff.sh
Pop-Location
Write-Host "Updating Crater Manipulator..." -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Dev\crater-manipulator"
git stash --quiet
git pull
git stash pop --quiet
Pop-Location
