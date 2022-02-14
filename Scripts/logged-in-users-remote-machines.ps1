#$Servers = Get-Content -path C:\prakash.txt

$Serv1 = Read-Host -Prompt "ENTER THE LIST TO FIND LOGGED IN USERS"
#$Servers = Get-Content -path C:\prakashp\services_host.txt
$servers = Get-Content $serv1

    foreach($servername in $Servers){
    $Pingcheck= Test-Connection -ComputerName $servername -count 1 -Quiet

    if($Pingcheck -eq "true")
    {
    

    foreach ($ser in $servername ){
    
    Write-Output "------------------------------$ser--------------------------------------- "
    $cool = query user /server:$ser 
    $cool 
    $ErrorActionPreference = 'silentlycontinue'
    
  }
   
    }
    
}