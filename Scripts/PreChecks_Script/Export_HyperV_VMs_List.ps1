$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
#$Serv1 = Read-Host -Prompt "ENTER Hyper-V hosts TXT FILE:"
$Servers = Get-Content -path C:\Powershell_Scripts\Scripts\PreChecks_Script\Servers1.txt
#$servers = Get-Content $serv1

foreach($servername in $Servers){

    foreach ($ser in $servername ){
    Write-Output "------------------$ser---------------------"
    $cool = Invoke-Command -ComputerName $servername -ScriptBlock { Import-Module Hyper-v ; get-vm | Where-Object {$_.state -eq 'Running'} | select VMname,state} 
    $cool | select VMName,state,PSComputerName}
    $Line = "--------------" 
    $Space = "                          "

                   $cool | Export-Csv C:\Powershell_Scripts\Scripts\PreChecks_Script\HyperV_VMs_List_Backup-$date.csv -Append
             
    #$cool
    #
}
