# Script from: https://github.com/microsoft/WSL/issues/4150#issuecomment-504209723
# Minus port forwarding, this is ONLY the firewall parts

#[Ports]

#All the ports you want to open separated by comma
$ports=@(22,80,443,3000,3001,3003,8080);
$ports_a = $ports -join ",";

#Remove Firewall Exception Rules
Invoke-Expression "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' ";

#adding Exception Rules for inbound and outbound Rules
Invoke-Expression "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";
Invoke-Expression "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";
