$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
$Servers = Get-Content -path C:\prakash.txt
$path = "\\tsa2\prakashp\Post-check-services-$date"

If (!(Test-Path $path))
{
New-Item -ItemType Directory -Path "\\tsa2\prakashp\Post-check-services-$date"
}


foreach($server in $servers)
{
Get-Service -ComputerName $Server | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\tsa2\prakashp\Post-check-services-$date\post_$server.txt
Add-Content \\tsa2\prakashp\Post-check-services-$date\post_$server.txt "------------------------------$server ------------------------------";
}
