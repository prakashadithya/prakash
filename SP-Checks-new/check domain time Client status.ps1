

$Serv1 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
$servers = Get-Content $serv1


#$Servers = Get-Content -path C:\prakash1.txt


foreach($servernames in $Servers){

    $Pingcheck= Test-Connection -ComputerName $servernames -count 1 -Quiet
    $pathtest= Test-Path \\$servernames\c$

    if($Pingcheck -eq "true" -and $pathtest -eq "true")

    {

    Invoke-Command -ComputerName $servernames -ScriptBlock { Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* ; Get-ItemProperty HKLM:\Software\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\*} | Select-Object DisplayName, DisplayVersion, PSComputerName | Where-Object { $_.DisplayName -like "Domain Time Client*"}}
     
 else

    {

    Write-Host "$servernames is not reachable" -ForegroundColor Red

    }

}



   