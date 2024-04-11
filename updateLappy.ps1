Push-Location "C:\Dev\crater-manipulator"
git pull
Pop-Location

Push-Location "C:\Dev\space-game"
git pull
Pop-Location

Write-Host "Before you leave you will probably want to:" -ForegroundColor Yellow -BackgroundColor black
Write-Host "  - Ensure recent crater-maipulator and/or space-game updates are pushed." -ForegroundColor Blue -BackgroundColor black
Write-Host "  - Run updateallTheThingsWindows.ps1 as admin to get Windows updated." -ForegroundColor Blue -BackgroundColor black
Write-Host "  - Check for Windows Updates." -ForegroundColor Blue -BackgroundColor black
Write-Host "  - Run VS Code once to ensure it has updates." -ForegroundColor Blue -BackgroundColor black
Write-Host "  - Make sure laptop and power bank are fully charged." -ForegroundColor Blue -BackgroundColor black

Write-Host "The assumption is that you will do most work by remoting your desktop, but it is good to have your laptop ready to work locally too."
