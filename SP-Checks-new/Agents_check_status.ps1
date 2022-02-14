$Servers = Get-Content "C:\Powershell_Scripts\Scripts\Servers.txt"
foreach($Server in $Servers)
{
$out=New-Object PSObject
$BESClient=Get-Service -ComputerName $Server -Name bescl*
$Nxlog=Get-Service -ComputerName $Server -Name nxlog*
$FireEye=Get-Service -ComputerName $Server -Name xagt*
$out | Add-Member -MemberType NoteProperty -Name "Servername" -Value $Server
$out | Add-Member -MemberType NoteProperty -Name "Bigfix" -Value $BESClient.Status
$out | Add-Member -MemberType NoteProperty -Name "Nxlog" -Value $Nxlog.Status
$out | Add-Member -MemberType NoteProperty -Name "FireEye" -Value $FireEye.Status
$out | export-csv C:\Agent_Status.csv -NoTypeInformation -Append

}