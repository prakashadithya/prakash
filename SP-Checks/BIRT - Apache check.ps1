$Servers = Get-Content C:\Prakash.txt
foreach($Server in $Servers)
{
Get-Service -ComputerName $Server -Name apache*
"$Server"
}