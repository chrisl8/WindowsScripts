param($commit)

if (-not $commit)
{
    Write-Host "No commit provided. Exiting script." -ForegroundColor Red
    exit
}

$noCommitChange = $false

if ($commit -eq "this")
{
    $noCommitChange = $true
    $commit = git rev-parse HEAD
    Write-Host $commit
}

$folderPath = "D:\GodotCustomBuilds\$commit"

if (-not (Test-Path -Path $folderPath))
{
    if ($noCommitChange)
    {
        Write-Host "Building current Godot Commit $commit" -ForegroundColor Yellow -BackgroundColor black
    }
    else
    {
        Write-Host "Building Godot at Commit $commit" -ForegroundColor Yellow -BackgroundColor black
        Push-Location "C:\Users\chris\CLionProjects\godot\"
        gh repo sync chrisl8/godot
        git fetch
        git checkout $commit
    }
    if (Test-Path 'bin')
    {
        Remove-Item -Recurse -Force 'bin'
    }
    scons -Q production=yes
    New-Item -ItemType Directory -Path D:\GodotCustomBuilds\$commit
    Copy-Item .\bin\* D:\GodotCustomBuilds\$commit\

    if (!$noCommitChange)
    {
        Pop-Location
    }
}

Write-Host "Starting Godot at Commit $commit" -ForegroundColor Yellow -BackgroundColor black
#Push-Location "C:\Dev\space-game-clean"
Push-Location "D:\godot-demo-projects-clean\3d\global_illumination"
Write-Host "Cleaning up Demo repo..." -ForegroundColor Yellow -BackgroundColor black
git checkout master
git pull
git reset --hard HEAD
if (Test-Path '.godot')
{
    Remove-Item -Recurse -Force '.godot'
}
$arguments = "-e"
Start-Process "D:\GodotCustomBuilds\$commit\godot.windows.editor.x86_64.exe" -ArgumentList $arguments
Pop-Location
