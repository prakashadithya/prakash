    $date = Get-Date
    $date = $date.ToString("yyyy-MM-dd")
    $Servers = Get-Content -path C:\prakash.txt
    $path = "\\tsa2\prakashp\Pre-check-services-$date"

    If (!(Test-Path $path))
    {
    New-Item -ItemType Directory -Path "\\tsa2\prakashp\Pre-check-services-$date"
    }

    #IF BACKUP IS NOT HAPPENING THOUGH SCRPIT
    #Get-Service -ComputerName BOPADAM01OCB | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\tsa2\prakashp\Pre-check-services-$date\pre_BOPADAM01OCB.txt
    #PRE _ CHECK SCCM PATH : \\sccm01ocb\SCCM\Outputs\Services\Prechecks\Pre-check-services
    #CFSDOM SAVE FILE:
    #Get-Service | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\cfsdom2b\c$\scripts\Outputs\prakashp\Pre-check-services\pre_$env:COMPUTERNAME.txt
    #Get-Service | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\cfsdom2b\c$\scripts\Outputs\prakashp\Post-check-services\post_$env:COMPUTERNAME.txt

    #Get-Service | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\cfsdom2b\c$\scripts\Pre-checks\pre_$env:COMPUTERNAME.txt
    #Get-Service | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\cfsdom2b\c$\scripts\Post-checks\post_$env:COMPUTERNAME.txt

    #LOCAL MACHINE
    #Get-Service | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\tsa2\C$\prakashp\remote-services-pre\pre_$env:COMPUTERNAME.txt 
    #Get-Service | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\tsa2\C$\prakashp\remote-services-post\post_$env:COMPUTERNAME.txt

    foreach($server in $servers)
    {
    Get-Service -ComputerName $Server | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\tsa2\prakashp\Pre-check-services-$date\pre_$server.txt
    Add-Content \\tsa2\prakashp\Pre-check-services-$date\pre_$server.txt "------------------------------$server ------------------------------";
    }



