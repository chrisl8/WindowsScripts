param($force)
Write-Host "Checking Godot Repository for Updates..." -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Users\chris\CLionProjects\godot\"
gh repo sync chrisl8/godot
#gh repo sync chrisl8/godot --branch 4.2
git stash --quiet
git fetch
$local = git rev-parse "@"
$remote = git rev-parse "@{u}"
if ($local -ne $remote -Or $force -eq "--force") {
    Write-Host " Changes found!" -ForegroundColor Blue -BackgroundColor black
    Write-Host "  Pulling updates for Godot..." -ForegroundColor Blue -BackgroundColor black
    git pull
    git stash pop --quiet
    Write-Host "  Building new version of Godot..." -ForegroundColor Blue -BackgroundColor black
    Remove-Item -R -Force .\bin
    scons -Q production=yes
    Copy-Item .\bin\* C:\Users\chris\OneDrive\allWindows\GodotEngines\custom\
    Copy-Item .\bin\* "C:\Users\chris\OneDrive\Ben + Dad - Shared Folder\GodotEngines\custom"
    Write-Host "  Built godot with the following changes:" -ForegroundColor Blue -BackgroundColor black
    git --no-pager log --oneline ^"$local" "$remote"
} else {
    git stash pop --quiet
    Write-Host "No changes found."
}
$godot_version = C:\Users\chris\OneDrive\allWindows\GodotEngines\custom\godot.windows.editor.x86_64.console.exe --version
Write-Host "Godot version $godot_version is built and installed." -ForegroundColor Yellow -BackgroundColor black
Pop-Location

Write-Host "Checking Godot VSCode Plugin..." -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Dev\godot-vscode-plugin\"
git stash --quiet
git fetch
$local = git rev-parse "@"
$remote = git rev-parse "@{u}"
if ($local -ne $remote) {
    Write-Host "Changes found:"
    git --no-pager log --oneline ^"$local" "$remote"
    Remove-Item .\godot-tools-*.vsix
    git pull
    git stash pop --quiet
    npm i
    npm run package
    Copy-Item .\godot-tools-*.vsix C:\Users\chris\OneDrive\allWindows\GodotEngines\godot-vs-code-plugin
    Copy-Item .\godot-tools-*.vsix "C:\Users\chris\OneDrive\Ben + Dad - Shared Folder\GodotEngines\godot-vs-code-plugin"
    Set-Location
} else {
    git stash pop --quiet
    Write-Host "No changes found."
}
Pop-Location

Write-Host "Checking Lint and Format VSCode Plugin..." -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Dev\vscode-formatter-godot\"
gh repo sync chrisl8/vscode-formatter-godot
git stash --quiet
git fetch
$local = git rev-parse "@"
$remote = git rev-parse "@{u}"
if ($local -ne $remote) {
    Write-Host "Changes found:"
    git --no-pager log --oneline ^"$local" "$remote"
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
    Write-Host "No changes found."
}
Pop-Location

Write-Host "Checking Godot GDScript Toolkit..." -ForegroundColor Yellow -BackgroundColor black
Push-Location "C:\Dev\godot-gdscript-toolkit\"
gh repo sync chrisl8/godot-gdscript-toolkit
git stash --quiet
git fetch
$local = git rev-parse "@"
$remote = git rev-parse "@{u}"
if ($local -ne $remote) {
    Write-Host "Changes found:"
    git --no-pager log --oneline ^"$local" "$remote"
    git pull
    git stash pop --quiet
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList "pip3 install -e C:\Dev\godot-gdscript-toolkit"
    Copy-Item -Force -recurse "C:\Dev\godot-gdscript-toolkit" "C:\Users\chris\OneDrive\Ben + Dad - Shared Folder\GodotEngines\"
    Set-Location
} else {
    git stash pop --quiet
    Write-Host "No changes found."
}
Pop-Location
