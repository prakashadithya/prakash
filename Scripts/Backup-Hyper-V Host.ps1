

$Servone = Read-Host -Prompt "ENTER THE LIST OF HYPER_V HOST TEXT FILE:"
$servers = Get-Content $servone




function FindVM {

foreach($servername in $Servers){

    foreach ($ser in $servername ){
    #Write-Output "------------------$ser---------------------"
    $cool = Invoke-Command -ComputerName $servername -ScriptBlock { Import-Module Hyper-v ; get-vm | Where-Object {$_.state -eq 'Running'} | select VMname} 
    $cool.VMName
    }
 }
}

#$Servers = Get-Content -path C:\Powershell_Scripts\Scripts\servers.txt
$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
#$Serv = Get-Content C:\prakashp\prakash.txt
$Serv = FindVM
$path = "\\TSA2\Powershell_Scripts\Outputs\Services\Prechecks\Pre-check-services-$date"

If (!(Test-Path $path))
{
New-Item -ItemType Directory -Path "\\TSA2\Powershell_Scripts\Outputs\Services\Prechecks\Pre-check-services-$date"
}

foreach($serv1 in $Servers)
{
Get-Service -ComputerName $Serv1 | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\TSA2\Powershell_Scripts\Outputs\Services\Prechecks\Pre-check-services-$date\Pre_$serv1.txt
Add-Content \\TSA2\Powershell_Scripts\Outputs\Services\Prechecks\Pre-check-services-$date\Pre_$serv1.txt "------------------------------$server ------------------------------";
}

foreach($server in $Serv)
{
Get-Service -ComputerName $Server | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\TSA2\Powershell_Scripts\Outputs\Services\Prechecks\Pre-check-services-$date\Pre_$server.txt
Add-Content \\TSA2\Powershell_Scripts\Outputs\Services\Prechecks\Pre-check-services-$date\Pre_$server.txt "------------------------------$server ------------------------------";
}
