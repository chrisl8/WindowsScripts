c:

rm -R -Force C:\Dev\space-game\addons
mkdir C:\Dev\space-game\addons

$path = "C:\Dev\godot-jwt"
if(!(test-path -PathType container $path))
{
    cd c:\Dev
    gh repo clone fenix-hub/godot-engine.jwt godot-jwt -- --branch main-godot4
}
cd c:\Dev\godot-jwt
git pull
cp -R C:\Dev\godot-jwt\addons\jwt C:\Dev\space-game\addons

$path = "C:\Dev\godot-mirror"
if(!(test-path -PathType container $path))
{
    cd c:\Dev
    gh repo clone Norodix/GodotMirror godot-mirror -- --branch godot4
}
cd c:\Dev\godot-mirror
git pull
cp -R C:\Dev\godot-mirror\addons\Mirror C:\Dev\space-game\addons

$path = "C:\Dev\godot-uuid"
if(!(test-path -PathType container $path))
{
    cd c:\Dev
    gh repo clone binogure-studio/godot-uuid
}
cd c:\Dev\godot-uuid
git pull
cp -R C:\Dev\godot-uuid\addons\uuid C:\Dev\space-game\addons

rm -R -Force C:\Dev\space-game-xr\addons
cp -R C:\Dev\space-game\addons C:\Dev\space-game-xr

$path = "C:\Dev\godot-xr-tools"
if(!(test-path -PathType container $path))
{
    cd c:\Dev
    gh repo clone GodotVR/godot-xr-tools
}
cd c:\Dev\godot-xr-tools
git pull
cp -R C:\Dev\godot-xr-tools\addons\godot-xr-tools C:\Dev\space-game-xr\addons

bash patchGodotMirrorAddon.sh

cd
