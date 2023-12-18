Push-Location "C:\Dev\space-game-xr"
git stash -u --quiet
git fetch
$output = git diff --name-only origin/main
git stash pop --quiet
if ($output) {
    git pull
}
Push-Location $PSScriptRoot
bash diffSpaceGameXr.sh
Pop-Location
Pop-Location
