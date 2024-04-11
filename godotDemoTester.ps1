function RemoveJunkLinesFrom($inputFilePath)
{
    # Define the list of strings
    $stringList = @("Invalid pipelines cache header", "RenderingDeviceDriverVulkan::pipeline_cache_create", "rendering_device_driver_vulkan.cpp:3833", "Viewport Texture must be set to use it", "ViewportTexture::get_", "old surface format", "fix_surface_compatibility", "Capture track found.", "animation_player.cpp:435")

    # Define the path to the input file and the output file
    $outputFilePath = "D:\temp\strippedFile.txt"
    New-Item -ItemType File -Path $outputFilePath -Force > $null

    # Read the input file line by line
    Get-Content -Path $inputFilePath | ForEach-Object {
        # Store the current line in a variable
        $line = $_

        # Assume that the line does not contain any of the strings
        $containsString = $false

        # Check each string in the list
        foreach ($string in $stringList) {
            if ($line -match $string) {
                Write-Host "Ignoring line: $line"
                # If the line contains the string, set the flag to true and break the loop
                $containsString = $true
                break
            }
        }

        # If the line does not contain any of the strings, write it to the output file
        if (-not $containsString) {
            $line | Out-File -FilePath $outputFilePath -Append
        }
    }

    # Overwrite input file with new content
    Get-Content -Path $outputFilePath | Out-File -FilePath $inputFilePath
}

function TestGodotDemoProject($projectFolder, $godotExecutablePath, $outputFile, $godotVersionName)
{
    $tempData = "d:\temp\tempData.txt"
    #a$godotExecutablePath | Out-File -FilePath $outputFile
    $title = "Checking Godot Project $projectFolder with Godot $godotVersionName"
    Write-Host $title  -ForegroundColor Yellow -BackgroundColor black
    $title | Out-File -FilePath $tempData
    Push-Location $projectFolder

    # Remove the .godot folder, because that is how users will expect to initially load them.
    # Otherwise this may leave traces of my previous loading of the project.
    if (Test-Path '.godot') {
        Remove-Item -Recurse -Force '.godot'
    }

    $stdErrLog = "d:\temp\stderrEditor.log"
    $stdOutLog = "d:\temp\stdoutEditor.log"

    # Do an import to make sure the project is ready to run.
    $arguments = "-e --import"
    $process = Start-Process $godotExecutablePath -ArgumentList $arguments -PassThru -RedirectStandardOutput $stdOutLog -RedirectStandardError $stdErrLog
    while (!$process.HasExited)
    {
        # Wait for the import to finish.
        Start-Sleep -Seconds 1
    }
    Start-Sleep -Seconds 1 # Give it a moment to release all file locks.

    # Now run it once in the editor to look for errors that only happen then.
    $arguments = "-e"
    $process = Start-Process $godotExecutablePath -ArgumentList $arguments -PassThru -RedirectStandardOutput $stdOutLog -RedirectStandardError $stdErrLog
    # Wait a few seconds for it to start up, and settle, then cose it.
    $countDown = 5
    while ($countDown -gt 0)
    {
        Start-Sleep -Seconds 1
        $countDown--
        if ($process.HasExited)
        {
            break
        }
    }
    # Check if the process is still running
    if (!$process.HasExited)
    {
        # Stop the process
        Stop-Process -Id $process.Id
    }
    Start-Sleep -Seconds 1 # Give it a moment to release all file locks.

    # Check for and capture any errors.
    RemoveJunkLinesFrom $stdOutLog
    $stdOutLineCount = (Get-Content -Path $stdOutLog | Measure-Object -Line).Lines
    if ($stdOutLineCount -gt 2)
    {
        Get-Content -Path $stdOutLog | Select-Object -Skip 2 | Out-File -FilePath $tempData -Append
    }
    RemoveJunkLinesFrom $stdErrLog
    $stdErrLineCount = (Get-Content -Path $stdErrLog | Measure-Object -Line).Lines
    if ($stdErrLineCount -gt 0)
    {
        Get-Content -Path $stdErrLog | Out-File -FilePath $tempData -Append
    }

    # And run it one last time starting the game up instead of using the editor.
    $process = Start-Process $godotExecutablePath -PassThru -RedirectStandardOutput $stdOutLog -RedirectStandardError $stdErrLog

    # Check to see if we have an AutoHotkey script to run, and use it if we do.
    $scriptDirectory = $PSScriptRoot
    $testingScriptFolder = $projectFolder.ToString().Replace($godotDemoProjectFolder, "$scriptDirectory\godotGameTesting\")
    $testScript = "$testingScriptFolder\test.ahk"
    if (Test-Path $testScript) {
        # Run the AutoHotkey script to test the game.
        Start-Process AutoHotkey64.exe $testScript
    } else {
        # Otherwise just let the game run for a few seconds and then kill it.
        $countDown = 10
        while ($countDown -gt 0)
        {
            Start-Sleep -Seconds 1
            $countDown--
            if ($process.HasExited)
            {
                break
            }
        }

        # Check if the process is still running
        if (!$process.HasExited)
        {
            # Stop the process
            Stop-Process -Id $process.Id
        }
    }

    while (!$process.HasExited)
    {
        # Wait for the import to finish.
        Start-Sleep -Seconds 1
    }
    Start-Sleep -Seconds 1 # Give it a moment to release all file locks.

    RemoveJunkLinesFrom $stdOutLog
    $stdOutLineCount = (Get-Content -Path $stdOutLog | Measure-Object -Line).Lines
    if ($stdOutLineCount -gt 2)
    {
        Get-Content -Path $stdOutLog | Select-Object -Skip 2 | Out-File -FilePath $tempData -Append
    }

    RemoveJunkLinesFrom $stdErrLog
    $stdErrLineCount = (Get-Content -Path $stdErrLog | Measure-Object -Line).Lines
    if ($stdErrLineCount -gt 0)
    {
        Get-Content -Path $stdErrLog | Out-File -FilePath $tempData -Append
    }

    $tempDataLineCount = (Get-Content -Path $tempData | Measure-Object -Line).Lines
    if ($tempDataLineCount -gt 1)
    {
        "---------------------------------------------------------------------" | Out-File -FilePath $outputFile
        Get-Content -Path $tempData | Out-File -FilePath $outputFile -Append
    }

    Pop-Location
}

function TestGodotDemoProjects($demoProjectFolders, $resultFile)
{
    foreach ($demoProjectFolder in $demoProjectFolders)
    {
        $projectFolder = $demoProjectFolder.Directory

        #$outputFile1 = "d:\temp\godotDemoTesterStable.log"
        $outputFile2 = "d:\temp\godotDemoTesterMaster.log"

        #        $godotVersionName = "4.2 Stable"
#        $godotExecutablePath = "C:\Users\chris\OneDrive\allWindows\GodotEngines\Godot_v4.2.1-stable_win64.exe\Godot_v4.2-stable_win64.exe"
#        $outputFile = $outputFile1
#        TestGodotDemoProject -projectFolder $projectFolder -godotExecutablePath $godotExecutablePath -outputFile $outputFile -godotVersionName $godotVersionName
#        "**********************************************************************" | Out-File -FilePath $resultFile -Append
#        Get-Content -Path $outputFile | Out-File -FilePath $resultFile -Append

        $godotVersionName = "4.3 Master"
        $godotExecutablePath = "C:\Users\chris\CLionProjects\godot\bin\godot.windows.editor.x86_64.exe"
        $outputFile = $outputFile2
        New-Item -ItemType File -Path $outputFile -Force > $null
        TestGodotDemoProject -projectFolder $projectFolder -godotExecutablePath $godotExecutablePath -outputFile $outputFile -godotVersionName $godotVersionName
        Get-Content -Path $outputFile | Out-File -FilePath $resultFile -Append
    }
}

$godotDemoProjectFolder = "D:\godot-demo-projects-clean\"

Clear-Host

Push-Location $godotDemoProjectFolder
git cherry-pick --abort
gh repo sync chrisl8/godot-demo-projects
git checkout master
git reset --hard HEAD
git pull
# You can cherry-pick commits if you are waiting for fixes that you made PRs for to be merged.
#git cherry-pick aed4281f9dcef7dbe77e6ac60cfecf6eb3a473fd c45f803edd05c692dc9f153b619806d51172a6f7 3ef6a15741dca207638a18a65499ad0a905573c0
Pop-Location

# Put the WebRTC Godot Extension in where it is needed.
$webrtcAddonZipFileName = "godot-extension-4.1-webrtc.zip"
Push-Location "D:\godot-demo-projects-clean\networking\webrtc_minimal"
if (Test-Path 'webrtc')
{
    Remove-Item -Recurse -Force 'webrtc'
}
Copy-Item D:\$webrtcAddonZipFileName .
Expand-Archive .\$webrtcAddonZipFileName .
Remove-Item -Recurse -Force .\$webrtcAddonZipFileName
Pop-Location

Push-Location "D:\godot-demo-projects-clean\networking\webrtc_signaling"
if (Test-Path 'webrtc')
{
    Remove-Item -Recurse -Force 'webrtc'
}
Copy-Item D:\$webrtcAddonZipFileName .
Expand-Archive .\$webrtcAddonZipFileName .
Remove-Item -Recurse -Force .\$webrtcAddonZipFileName
Pop-Location

$skipMonoDemos = $true

if ($skipMonoDemos) {
    #Use Mob.tscn instead of prject.godot to test with only two demos.
    #$demoProjectFolders = Get-ChildItem -Path $godotDemoProjectFolder -Filter "Mob.tscn" -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Directory.FullName -notmatch '\\mono\\' } | Select-Object -Property Directory -Unique
    $demoProjectFolders = Get-ChildItem -Path $godotDemoProjectFolder -Filter "project.godot" -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Directory.FullName -notmatch '\\mono\\' } | Where-Object { $_.Directory.FullName -notmatch '\\xr\\' } | Select-Object -Property Directory -Unique
} else
{
    $demoProjectFolders = Get-ChildItem -Path $godotDemoProjectFolder -Filter "project.godot" -Recurse -ErrorAction SilentlyContinue | Select-Object -Property Directory -Unique
}

if (-not (Test-Path -Path "D:\temp\")) {
    New-Item -ItemType Directory -Path "D:\temp\"
}

$resultFile = "d:\temp\godotDemoTesterResults.log"
New-Item -ItemType File -Path $resultFile -Force > $null

TestGodotDemoProjects -demoProjectFolders $demoProjectFolders -resultFile $resultFile

if ($skipMonoDemos) {
    Write-Host "Mono and XR Demos were skipped." -ForegroundColor Yellow -BackgroundColor black
}

Get-Content -Path $resultFile
