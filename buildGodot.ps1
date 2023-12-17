Write-Host "Checking Godot..." -ForegroundColor Yellow -BackgroundColor black
Set-Location "C:\Users\chris\CLionProjects\godot\"
gh repo sync chrisl8/godot
gh repo sync chrisl8/godot --branch 4.2
git stash --quiet
$output = git status --porcelain
git stash pop --quiet
if ($output) {
    git pull
    scons production=yes
    Copy-Item .\bin\* D:\Dropbox\allWindows\GodotEngines\custom\
} else {
    Write-Host "No changes."
}


Write-Host "Checking VSCode Plugin..." -ForegroundColor Yellow -BackgroundColor black
Set-Location "C:\Dev\godot-vscode-plugin\"
$output = git status --porcelain
if ($output) {
    git pull
    npm i
    npm run package
    Copy-Item .\godot-tools-1.3.1.vsix D:\Dropbox\allWindows\GodotEngines\godot-vs-code-plugin
    Set-Location
} else {
    Write-Host "No changes."
}

Set-Location