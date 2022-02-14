$serv = Get-Content C:\prakash.txt


foreach ($server in $serv)
{
$content1 = Get-Content C:\prakashp\Pre-check-services-2020-06-18\pre_$server.txt
$content2 = Get-Content C:\prakashp\Post-check-services-2020-06-18\post_$server.txt





#COPY PASTE BEFORE THAT

$Diff = Compare-Object $content2 $content1

$LeftSide = ($Diff | Where-Object {$_.SideIndicator -eq '=>'} ).InputObject 
#$LeftSide | Out-File C:\prakashp\services\compare\services_$server.txt}

$out10 = foreach ($_ in $LeftSide)
            { $out = $_.split(); $out[1]}
#$out10 | Out-File C:\prakashp\services\compare\services_$server.txt

Write-Host "----------------$server--------------"

foreach ( $service in $out10 )
{

$status = Get-Service -ComputerName $server -Name $service -ErrorAction SilentlyContinue
if ($status.Status -eq 'Running')
    {Write-Host $service SERVICE IS ALREADY RUNNING -ErrorAction SilentlyContinue } 

    Elseif ($status.Status -eq 'Stopped')
    {Get-Service -ComputerName $server -Name $service | Start-Service 
     Write-Host $service SERVICE IS STARTED  -ErrorAction SilentlyContinue -ForegroundColor Green}

    elseif ($status = $Error[0] -and $service -ne 'Akana' )
    {Write-Host $service SERVICE NOT AVAILABLE IN THE CURRENT VERSION  -ErrorAction SilentlyContinue -ForegroundColor DarkYellow}
     
     elseif ($service -eq 'Akana' )
    {Get-Service -ComputerName BNDINTS01US1 -Name Akana* | Start-Service
    Write-Host Akana SERVICE IS STARTED  -ErrorAction SilentlyContinue -ForegroundColor Green}


    #{Write-Host $service is already running -ErrorAction SilentlyContinue } Else {

    #Get-Service -ComputerName $server -Name $service | Start-Service 

    #Write-Host $service Service is started  -ErrorAction SilentlyContinue}

    }
    
}