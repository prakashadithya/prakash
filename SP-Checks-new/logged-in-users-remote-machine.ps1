$Servers = Get-Content -path C:\Powershell_Scripts\Scripts\Servers1.txt

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