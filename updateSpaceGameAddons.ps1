$FolderName = "C:\Dev\space-game\addons"
Remove-Item -R -Force $FolderName
if (!(Test-Path $FolderName)) {
   #PowerShell Create directory if not exists
    New-Item $FolderName -ItemType Directory | Out-Null
    #Write-Host "Folder Created successfully"
}

Write-Host "Checking JWT addon..." -ForegroundColor Yellow -BackgroundColor black
$path = "C:\Dev\godot-jwt"
if(!(test-path -PathType container $path))
{
    Set-Location "c:\Dev"
    gh repo clone fenix-hub/godot-engine.jwt godot-jwt -- --branch main-godot4
}
Set-Location "c:\Dev\godot-jwt"
git pull
Copy-Item -R C:\Dev\godot-jwt\addons\jwt C:\Dev\space-game\addons

Write-Host "Checking Mirror addon..." -ForegroundColor Yellow -BackgroundColor black
$path = "C:\Dev\godot-mirror"
if(!(test-path -PathType container $path))
{
    Set-Location "c:\Dev"
    gh repo clone Norodix/GodotMirror godot-mirror -- --branch godot4
}
Set-Location "c:\Dev\godot-mirror"
git pull
Copy-Item -R C:\Dev\godot-mirror\addons\Mirror C:\Dev\space-game\addons

Write-Host "Checking UUID addon..." -ForegroundColor Yellow -BackgroundColor black
$path = "C:\Dev\godot-uuid"
if(!(test-path -PathType container $path))
{
    Set-Location "c:\Dev"
    gh repo clone binogure-studio/godot-uuid
}
Set-Location "c:\Dev\godot-uuid"
git pull
Copy-Item -R C:\Dev\godot-uuid\addons\uuid C:\Dev\space-game\addons

Remove-Item -R -Force C:\Dev\space-game-xr\addons
Copy-Item -R C:\Dev\space-game\addons C:\Dev\space-game-xr

Write-Host "Checking XR addon..." -ForegroundColor Yellow -BackgroundColor black
$path = "C:\Dev\godot-xr-tools"
if(!(test-path -PathType container $path))
{
    Set-Location "c:\Dev"
    gh repo clone GodotVR/godot-xr-tools
}
Set-Location "c:\Dev\godot-xr-tools"
git pull
Copy-Item -R C:\Dev\godot-xr-tools\addons\godot-xr-tools C:\Dev\space-game-xr\addons

# This patch is for web export, but it breaks the Mirror in XR export.
Push-Location $PSScriptRoot
bash patchGodotMirrorAddon.sh
