Function Find-Uptime

{

$machines=get-content((Read-Host 'Enter the computers list file Path here') -replace '"')

foreach($machine in $machines)

{

$Pingcheck= Test-Connection -ComputerName $machine -count 1 -Quiet

$pathtest= Test-Path \\$machine\c$

    if($Pingcheck -eq "true" -and $pathtest -eq "true")

    {

    $uptime=Get-WmiObject win32_operatingsystem -ComputerName $machine| select csname, @{LABEL='LastBootUpTime-UptimeServer';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}

    $uptime

    }

    else

    {

    Write-Host "$machine is not reachable" -ForegroundColor Red

    }

}

}

Find-Uptime

 