# Self-elevate the script if required
# https://stackoverflow.com/a/64576446
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

Write-Host "Updating Choclatey packages" -ForegroundColor Yellow -BackgroundColor black
choco upgrade all -y

Write-Host "Updating PIP" -ForegroundColor Yellow -BackgroundColor black
python.exe -m pip install --upgrade pip

Write-Host "Checking for Python Package Updates" -ForegroundColor Yellow -BackgroundColor black
pip install pip-review
pip list --outdated
Write-Host "Be careful about updating dependency packages!" -ForegroundColor Blue -BackgroundColor black
pip-review --interactive

