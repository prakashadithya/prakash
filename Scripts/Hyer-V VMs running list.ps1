
$serv1 = Read-Host -Prompt "ENTER THE HYPER-V HOST TO FIND THE RUNNING VM's"

foreach($servername in $serv1)
{
    $out = Invoke-Command -ComputerName $servername -ScriptBlock { Import-Module Hyper-v ; get-vm | Where-Object {$_.state -eq 'Running'} | select VMname,state} 
    $out | select VMName,state,PSComputerName
} 



