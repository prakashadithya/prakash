$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
$Servers = Get-Content -path C:\Powershell_Scripts\Scripts\PreChecks_Script\Servers.txt

    foreach($servername in $Servers){
    $Pingcheck= Test-Connection -ComputerName $servername -count 1 -Quiet

    if($Pingcheck -eq "true")
    {
    

    foreach ($ser in $servername ){
    
    Write-Output "------------------------------$ser--------------------------------------- "
       $cool = query user /server:$ser
       $Line = "--------------" 
       $Space = "                          "
    $cool

    $ErrorActionPreference = 'silentlycontinue'
  }
        $ser | Out-File C:\Powershell_Scripts\Outputs\Service_account_backup\Service_Account_Backup-$date.txt -Append
        $Line | Out-File C:\Powershell_Scripts\Outputs\Service_account_backup\Service_Account_Backup-$date.txt -Append
       $cool | Out-File C:\Powershell_Scripts\Outputs\Service_account_backup\Service_Account_Backup-$date.txt -Append
       $Space | Out-File C:\Powershell_Scripts\Outputs\Service_account_backup\Service_Account_Backup-$date.txt -Append
       
    }
    
}