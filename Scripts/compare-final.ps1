
$serv = Get-Content C:\Powershell_Scripts\Scripts\servers2.txt
foreach ($server in $serv)
{
$content1 = Get-Content C:\Powershell_Scripts\Outputs\Services\Prechecks\Pre-check-services-2020-03-02\pre_$server.txt
$content2 = Get-Content C:\Powershell_Scripts\Outputs\Services\Postchecks\Post-check-services-2020-03-03\post_$server.txt
$Diff = Compare-Object $content2 $content1

$LeftSide = ($Diff | Where-Object {$_.SideIndicator -eq '<='} ).InputObject 
#$LeftSide | Out-File C:\prakashp\services\compare\services_$server.txt}

$out10 = foreach ($_ in $LeftSide)
            { $out = $_.split(); $out[1]}
$out10 | Out-File C:\prakashp\services\compare\services_$server.txt

Write-Host "----------------$server--------------"

foreach ( $service in $out10 )
{

$status = Get-Service -ComputerName $server -Name $service
if ($status.Status -eq 'Running')
     
    {Write-Host $service is already running -ErrorAction SilentlyContinue } Else {

    Get-Service -ComputerName $server -Name $service | Start-Service 

    Write-Host $service Service is started  -ErrorAction SilentlyContinue}

    }
    
}