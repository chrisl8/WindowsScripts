# Self-elevate the script if required
# https://stackoverflow.com/a/64576446
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

# Write-Host
#https://www.pdq.com/powershell/write-host/
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host?view=powershell-7.4

Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "Updating Choclatey packages" -ForegroundColor Yellow -BackgroundColor black
choco upgrade all -y

Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "Updating PIP" -ForegroundColor Yellow -BackgroundColor black
python.exe -m pip install --upgrade pip

Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "Install Python Packages" -ForegroundColor Yellow -BackgroundColor black
pip install pip-review
pip install "gdtoolkit==4.*"

Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "Checking for Python Package Updates" -ForegroundColor Yellow -BackgroundColor black
pip list --outdated

Write-Host "" -ForegroundColor Blue -BackgroundColor black
Write-Host "Be careful about updating dependency packages!" -ForegroundColor Blue -BackgroundColor black
pip-review --interactive

Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "Updating Windows Packages" -ForegroundColor Yellow -BackgroundColor black
winget upgrade --all

Write-Host "" -ForegroundColor Yellow -BackgroundColor black
Write-Host "Forcing Windows Store Update Check" -ForegroundColor Yellow -BackgroundColor black
# https://github.com/microsoft/winget-cli/issues/2854#issuecomment-1435369342
Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod

Write-Host "" -ForegroundColor Blue -BackgroundColor black
Write-Host "Check Video Driver version" -ForegroundColor Blue -BackgroundColor black
&"C:\Program Files\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA GeForce Experience.exe"

Write-Host "" -ForegroundColor Blue -BackgroundColor black
Write-Host "Check for MS Store Updates" -ForegroundColor Blue -BackgroundColor black
start ms-windows-store: