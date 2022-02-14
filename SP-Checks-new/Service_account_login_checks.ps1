$Servers = Get-Content -path C:\prakash6.txt

    foreach($servername in $Servers){
    $Pingcheck= Test-Connection -ComputerName $servername -count 1 -Quiet

    if($Pingcheck -eq "true")
    {
    

    foreach ($ser in $servername ){
    Write-Output "------------------------------$ser--------------------------------------- "
    Write-Output "------------------------------------------------------------------------- "
    $cool = query user /server:$ser 
    $cool 
    $ErrorActionPreference = 'silentlycontinue'
    
  }
   
    }
    
}