$Servers = Get-Content "C:\Powershell_Scripts\Scripts\Prod General App servers.txt"
foreach($Server in $Servers)
{
Get-Service -ComputerName $Server -Name BESClient*
"$Server"
}