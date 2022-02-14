

#$Serv1 = Read-Host -Prompt "ENTER THE Pre-CHECK FILES PATH:"
#$servers = Get-Content $serv1

$Servers = Get-Content -path C:\prakash.txt
$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
#$Serv = Get-Content C:\prakashp\prakash.txt
$Serv = FindVM
$path = "\\tsa2\prakashp\Pre-check-services-$date"

function FindVM {

foreach($servername in $Servers){

    foreach ($ser in $servername ){
    #Write-Output "------------------$ser---------------------"
    $cool = Invoke-Command -ComputerName $servername -ScriptBlock { Import-Module Hyper-v ; get-vm | Where-Object {$_.state -eq 'Running'} | select VMname} 
    $cool.VMName
    }
 }
}

If (!(Test-Path $path))
{
New-Item -ItemType Directory -Path "\\tsa2\prakashp\Pre-check-services-$date"
}

foreach ($serv1 in $Servers){
$path1 = "\\tsa2\prakashp\Pre-check-services-$date\$serv1"
If (!(Test-Path $path1))
{
New-Item -ItemType Directory -Path "\\tsa2\prakashp\Pre-check-services-$date\$serv1"  
}
        foreach($server in $Serv)
        {
            Get-Service -ComputerName $Server | Sort-Object DisplayName  | Format-Table -AutoSize | Out-File \\tsa2\prakashp\Pre-check-services-$date\$serv1\Pre_$server.txt
            Add-Content \\tsa2\prakashp\Pre-check-services-$date\$serv1\Pre_$server.txt "------------------------------$server ------------------------------";
        }

}

