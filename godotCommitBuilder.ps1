param($commit)

if (-not $commit) {
    Write-Host "No commit provided. Exiting script." -ForegroundColor Red
    exit
}

$folderPath = "D:\GodotCustomBuilds\$commit"

if (-not (Test-Path -Path $folderPath)) {
    Write-Host "Building Godot at Commit $commit" -ForegroundColor Yellow -BackgroundColor black
    Push-Location "C:\Users\chris\CLionProjects\godot\"
    gh repo sync chrisl8/godot
    git fetch
    git checkout $commit
    scons production=yes
    New-Item -ItemType Directory -Path D:\GodotCustomBuilds\$commit
    Copy-Item .\bin\* D:\GodotCustomBuilds\$commit\
    Pop-Location
}

Write-Host "Starting Godot at Commit $commit" -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Dev\space-game-clean"
$arguments = "-e"
Start-Process "D:\GodotCustomBuilds\$commit\godot.windows.editor.x86_64.exe" -ArgumentList $arguments
Pop-Location
