
$serv1 = Read-Host -Prompt "ENTER THE LIST OF SERVERS PATH IN TEXT FILE:"
$serv = Get-Content $serv1

$content11 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
$content21 = Read-Host -Prompt "ENTER THE POST-CHECK FILES PATH:"


foreach ($server in $serv)
{
$content1 = Get-Content $content11\pre_$server.txt
$content2 = Get-Content $content21\post_$server.txt
$Diff = Compare-Object $content2 $content1

$LeftSide = ($Diff | Where-Object {$_.SideIndicator -eq '=>'} ).InputObject 
#$LeftSide | Out-File C:\prakashp\services\compare\services_$server.txt}
#$LeftSide

$out10 = foreach ($_ in $LeftSide)
            { $out = $_.split(); $out[1]}
$out10 | Out-File C:\prakashp\services\compare\services_$server.txt

Write-Host "----------------$server--------------"

foreach ( $service in $out10 )
{

$status = Get-Service -ComputerName $server -Name $service -ErrorAction SilentlyContinue
if ($status.Status -eq 'Running')
    {Write-Host $service SERVICE IS ALREADY RUNNING -ErrorAction SilentlyContinue } 
    Elseif ($status.Status -eq 'Stopped')
    {Write-Host $service SERVICE NEEDS TO BE STARTED  -ErrorAction SilentlyContinue -BackgroundColor Red}
    elseif ($status = $Error[0])
    {Write-Host $service SERVICE NOT AVAILABLE IN THE CURRENT VERSION  -ErrorAction SilentlyContinue -ForegroundColor Yellow}

    }
  }
 