$Servers= Get-Content -Path C:\Users\prakashpadmin\Desktop\SP-Checks\Servers.txt
foreach ($Server in $Servers)
{

Write-Host "-------------------------------$server-------------------------------" -BackgroundColor Yellow
Get-Service -ComputerName $server|Where-Object {$_.Name -eq "ALG"}

}

