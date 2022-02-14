$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
$Servers = Get-Content -path C:\Powershell_Scripts\Scripts\Servers3.txt
$path = "C:\Powershell_Scripts\Outputs\Services\Postchecks\Post-check-services-$date"

If (!(Test-Path $path))
{
New-Item -ItemType Directory -Path "C:\Powershell_Scripts\Outputs\Services\Postchecks\Post-check-services-$date"
}


foreach($server in $servers)
{
Get-Service -ComputerName $Server | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\TSA2\Powershell_Scripts\Outputs\Services\Postchecks\Post-check-services-$date\post_$server.txt
Add-Content \\TSA2\Powershell_Scripts\Outputs\Services\Postchecks\Post-check-services-$date\post_$server.txt "------------------------------$server ------------------------------";
}


