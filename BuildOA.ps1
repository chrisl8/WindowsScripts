# Clear old build files
rm -Recurse -Force 'C:\Users\chris\OneDrive\Pandorica\ObsoleteAeonBuild\*'

# Run Unity build script
# Piping output allows us to see it and makes script wait for .exe run to finish
# https://stackoverflow.com/a/7272390/4982408
& 'C:\Program Files\Unity\Hub\Editor\2022.3.14f1\Editor\Unity.exe' -quit -batchmode -nographics -executeMethod Builder.BuildProject -projectPath 'D:\Unity\Obsolete Aeon\' | Out-Default

# Copy in the Steam ID file so we can play multiplayer
cp 'D:\Unity\Obsolete Aeon\steam_appid.txt' C:\Users\chris\OneDrive\Pandorica\ObsoleteAeonBuild

Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "NOTICE:" -ForegroundColor Yellow -BackgroundColor black
Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "Unity Version: The script cannot update the Unity version, so if you updated Unit recently update this script too." -ForegroundColor Yellow -BackgroundColor black
Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "Scenes: The script only builds scenes that are included in \Assets\Editor\Builder.cs" -ForegroundColor Yellow -BackgroundColor black
Write-Host "So if a scene isn't ending up in your build, update that file to match the checked scenes in the Unity editor." -ForegroundColor Yellow -BackgroundColor black
