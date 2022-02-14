   $date = Get-Date
    $date = $date.ToString("yyyy-MM-dd")
    
    $serv1 = Read-Host -Prompt "ENTER THE LIST OF PHYSICAL SERVERS"
    $Servers = Get-Content $serv1
    #$Servers = Get-Content -path C:\prakash.txt
    $path = "\\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date"

    If (!(Test-Path $path))
    {
    New-Item -ItemType Directory -Path "\\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date"
    }

     foreach($server in $servers)
    {

    Invoke-Command -ComputerName $server -ScriptBlock {systeminfo}  | Out-File  \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt
    
    Add-Content \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt "-----------------------------NETWORK MGMT------------------------------";
    Invoke-Command -ComputerName $server -ScriptBlock { Get-NetAdapter | select Name, InterfaceDescription, Status | Format-Table -AutoSize} | Out-File  \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt -Append

    Add-Content \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt "----------------------------DRIVE DETAILS------------------------------";
    Get-WmiObject Win32_LogicalDisk -ComputerName $server -Filter DriveType=3 | Select-Object DeviceID, @{'Name'='Size (GB)'; 'Expression'={[math]::truncate($_.size / 1GB)}}, @{'Name'='Freespace (GB)'; 'Expression'={[math]::truncate($_.freespace / 1GB)}} | Out-File \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt -Append

    Add-Content \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt "-----------------------------IP CONFIG------------------------------";
    Invoke-Command -ComputerName $server -ScriptBlock {ipconfig /all } | Out-File  \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt -Append

    Add-Content \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt "-----------------------------DISK MGMT------------------------------";
    wmic /node:$server diskdrive get Name,Model,SerialNumber,Size,Status,MediaType,Partitions| Out-File  \\tsa2\Powershell_Scripts\Outputs\Physical_servers_backup\Physical-server-backup-$date\pre_$server.txt -Append

    }


