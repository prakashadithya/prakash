
Function vmlist{

$Serv1 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
#$Servers = Get-Content -path C:\prakashp\services_host.txtz
$servers = Get-Content $serv1

foreach($servername in $Servers){

    foreach ($ser in $servername ){
    Write-Output "------------------$ser---------------------"
    $cool = Invoke-Command -ComputerName $servername -ScriptBlock { Import-Module Hyper-v ; get-vm | select VMname,state} 
    $cool | select VMName,state,PSComputerName}
    #$cool
    #
}
}

vmlist | Out-File C:\vertualhostmachins.txt