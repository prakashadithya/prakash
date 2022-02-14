
$Servers= Get-Content -Path C:\Users\prakashpadmin\Desktop\SP-Checks\Servers.txt
foreach ($Server in $Servers)
{

	$PoolStatus = Invoke-Command -ComputerName $server {Import-Module WebAdministration; get-WebAppPoolState }
	$PoolStatus | Out-File "C:\prakashp\IIS-Output\iis.txt"
}