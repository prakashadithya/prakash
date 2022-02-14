

$Servers = Get-Content -path C:\prakash1.txt

    foreach($servername in $Servers){
    $Pingcheck= Test-Connection -ComputerName $servername -count 1 -Quiet

    if($Pingcheck -eq "true")
    {
    

    foreach ($ser in $servername ){
 
    #Write-Output "------------------$ser---------------------"  | out-file C:\software_version.txt -Append
    Get-CimInstance -Class CIM_Processor -ErrorAction Stop -ComputerName $ser | Select-Object PSComputerName, Name 
    
    }
    }
    
}






#Get-CimInstance -Class CIM_Processor -ErrorAction Stop -ComputerName CMGSASP3US1.cfs.betasys.com | Select-Object PSComputerName, Name 
