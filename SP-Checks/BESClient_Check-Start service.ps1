

$Servers = Get-Content "C:\prakash.txt"
foreach($Server in $Servers)
{
Get-Service BESC* -ComputerName $server | select name,status,machinename
}

