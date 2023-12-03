c:
cd C:\Users\chris\CLionProjects\godot\
gh repo sync chrisl8/godot
gh repo sync chrisl8/godot --branch 4.2
git pull
scons production=yes
cp .\bin\* D:\Dropbox\allWindows\GodotEngines\custom\

cd C:\Dev\godot-vscode-plugin\
git pull
npm i
npm run package
cp .\godot-tools-1.3.1.vsix D:\Dropbox\allWindows\GodotEngines\godot-vs-code-plugin
