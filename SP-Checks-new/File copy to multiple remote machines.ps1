$Servers = Get-Content "C:\Powershell_Scripts\Scripts\servers1.txt"
foreach($Server in $Servers)
{
Copy-Item C:\WSUS_CONFIG.reg -Destination \\$Server\c$ -Recurse
Copy-Item C:\WSUS_POLICY.reg -Destination \\$Server\c$ -Recurse
"$Server"
}
