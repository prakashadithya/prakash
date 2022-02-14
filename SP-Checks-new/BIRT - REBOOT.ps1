$Servers = Get-Content "C:\Prakash.txt"
foreach($Server in $Servers)
{
shutdown /m $Server -r -t 00
"$Server Rebooting Initiated"
}