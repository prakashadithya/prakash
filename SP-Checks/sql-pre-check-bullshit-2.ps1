   $date = Get-Date
    $date = $date.ToString("yyyy-MM-dd")
    $Servers = Get-Content -path C:\prakash.txt
    $path = "\\tsa2\prakashp\SQL-backup-$date"

    If (!(Test-Path $path))
    {
    New-Item -ItemType Directory -Path "\\tsa2\prakashp\SQL-backup-$date"
    }

     foreach($server in $servers)
    {

    Invoke-Command -ComputerName $server -ScriptBlock {systeminfo|findstr /c:"Host Name" /c:"OS Name" /c:"OS Version" /c:"OS Configuration" /c:"OS Build Type" /c:"Product ID" /c:"Original Install Date" /c:"System Boot Time" /c:"System Manufacturer" /c:"System Model" /c:"System Type" /c:"Processor(s)" /c:"BIOS Version"}  | Out-File  \\tsa2\prakashp\SQL-backup-$date\pre_$server.txt
    
    Add-Content \\tsa2\prakashp\SQL-backup-$date\pre_$server.txt "-----------------------------NETWORK MGMT------------------------------";
    Invoke-Command -ComputerName $server -ScriptBlock { Get-NetAdapter | select Name, InterfaceDescription, Status | Format-Table -AutoSize} | Out-File  \\tsa2\prakashp\SQL-backup-$date\pre_$server.txt -Append

    Add-Content \\tsa2\prakashp\SQL-backup-$date\pre_$server.txt "-----------------------------SQL SERVICES------------------------------";
    Get-WmiObject win32_Service -ComputerName $server -Filter "DisplayName LIKE '%SQL%'" | select Caption, StartName, StartMode, State | Format-Table -AutoSize | Out-File \\tsa2\prakashp\SQL-backup-$date\pre_$server.txt -Append
    
    Add-Content \\tsa2\prakashp\SQL-backup-$date\pre_$server.txt "----------------------------DISK MGMT------------------------------";
    Get-WmiObject Win32_LogicalDisk -ComputerName $server -Filter DriveType=3 | Select-Object DeviceID, @{'Name'='Size (GB)'; 'Expression'={[math]::truncate($_.size / 1GB)}}, @{'Name'='Freespace (GB)'; 'Expression'={[math]::truncate($_.freespace / 1GB)}} | Out-File \\tsa2\prakashp\SQL-backup-$date\pre_$server.txt -Append

    }


