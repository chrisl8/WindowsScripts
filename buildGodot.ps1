Write-Host "Checking Godot..." -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Users\chris\CLionProjects\godot\"
gh repo sync chrisl8/godot
gh repo sync chrisl8/godot --branch 4.2
git stash --quiet
git fetch
#$output = git diff --name-only origin/4.2
$output = git diff --name-only origin/master
if ($output) {
    git pull
    git stash pop --quiet
    scons production=yes
    Copy-Item .\bin\* C:\Users\chris\OneDrive\allWindows\GodotEngines\custom\
    Copy-Item .\bin\* "C:\Users\chris\OneDrive\Ben + Dad - Shared Folder\GodotEngines\custom"
} else {
    git stash pop --quiet
    Write-Host "No changes."
}
Pop-Location

Write-Host "Checking Godot VSCode Plugin..." -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Dev\godot-vscode-plugin\"
git fetch
$output = git diff --name-only origin/master
if ($output) {
    Remove-Item .\godot-tools-*.vsix
    git pull
    npm i
    npm run package
    Copy-Item .\godot-tools-*.vsix C:\Users\chris\OneDrive\allWindows\GodotEngines\godot-vs-code-plugin
    Copy-Item .\godot-tools-*.vsix "C:\Users\chris\OneDrive\Ben + Dad - Shared Folder\GodotEngines\godot-vs-code-plugin"
    Set-Location
} else {
    Write-Host "No changes."
}
Pop-Location

Write-Host "Checking Lint and Format VSCode Plugin..." -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Dev\vscode-formatter-godot\"
gh repo sync chrisl8/vscode-formatter-godot
git stash --quiet
git fetch
$output = git diff --name-only origin/main
if ($output) {
    Remove-Item .\gdscript-formatter-linter-*.vsix
    git pull
    git stash pop --quiet
    npm i
    npm run package
    Copy-Item .\gdscript-formatter-linter-*.vsix C:\Users\chris\OneDrive\allWindows\GodotEngines\vscode-formatter-godot
    Copy-Item .\gdscript-formatter-linter-*.vsix "C:\Users\chris\OneDrive\Ben + Dad - Shared Folder\GodotEngines\vscode-formatter-godot"
    Set-Location
} else {
    git stash pop --quiet
    Write-Host "No changes."
}
Pop-Location
