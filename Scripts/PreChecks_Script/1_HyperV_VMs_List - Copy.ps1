
#$Serv1 = Read-Host -Prompt "ENTER Hyper-V hosts TXT FILE:"
$Servers = Get-Content -path C:\Powershell_Scripts\Scripts\PreChecks_Script\Servers.txt
$servers = Get-Content $serv1

foreach($servername in $Servers){

    foreach ($ser in $servername ){
    Write-Output "------------------$ser---------------------"
    $cool = Invoke-Command -ComputerName $servername -ScriptBlock { Import-Module Hyper-v ; get-vm | select VMname,state} 
    $cool | select VMName,state,PSComputerName}
    $Line = "--------------" 
    $Space = "                          "

    $ser | Out-File C:\Powershell_Scripts\Outputs\HyperV_VMs_List\HyperV_VMs_List_Backup-$date.txt -Append
        $Line | Out-File C:\Powershell_Scripts\Outputs\HyperV_VMs_List\HyperV_VMs_List_Backup-$date.txt -Append
       $cool | Out-File C:\Powershell_Scripts\Outputs\HyperV_VMs_List\HyperV_VMs_List_Backup-$date.txt -Append
       $Space | Out-File C:\Powershell_Scripts\Outputs\HyperV_VMs_List\HyperV_VMs_List_Backup-$date.txt -Append
    #$cool
    #
}