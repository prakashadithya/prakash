$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
$Servers = Get-Content -path C:\prakash.txt
$path = "\\tsa2\prakashp\Post-check-services-$date"

If (!(Test-Path $path))
{
New-Item -ItemType Directory -Path "\\tsa2\prakashp\Post-check-services-$date"
}

#IF BACKUP IS NOT HAPPENING THOUGH SCRPIT
#Get-Service -ComputerName BOPADAM01OCB | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\tsa2\prakashp\Post-check-services-2020-05-05\post_BOPADAM01OCB.txt


foreach($server in $servers)
{
Get-Service -ComputerName $Server | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\tsa2\prakashp\Post-check-services-$date\$server.txt
}
