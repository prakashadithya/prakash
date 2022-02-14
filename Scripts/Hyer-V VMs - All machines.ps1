
$Serv1 = Read-Host -Prompt "ENTER Hyper-V hosts TXT FILE:"
#$Servers = Get-Content -path C:\prakash2.txt
$servers = Get-Content $serv1

foreach($servername in $Servers){

    foreach ($ser in $servername ){
    Write-Output "------------------$ser---------------------"
    $cool = Invoke-Command -ComputerName $servername -ScriptBlock { Import-Module Hyper-v ; get-vm | select VMname,state} 
    $cool | select VMName,state,PSComputerName}
    #$cool
    #
}