
$serv = Get-Content C:\prakashp\Input_for_codes\services_host.txt
foreach ($server in $serv)
{
$content1 = Get-Content C:\prakashp\Pre-check-services-2020-02-19\pre_$server.txt
$content2 = Get-Content C:\prakashp\Post-check-services-2020-02-19\post_$server.txt
$Diff = Compare-Object $content2 $content1
$diff


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