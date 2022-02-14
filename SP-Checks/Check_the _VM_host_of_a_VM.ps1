



$Servers = Get-Content -path C:\prakash1.txt

    foreach($servername in $Servers){
    $Pingcheck= Test-Connection -ComputerName $servername -count 1 -Quiet

    if($Pingcheck -eq "true")
    {
    

    foreach ($ser in $servername ){
 
    Write-Output "------------------$ser---------------------"  
    $cool = Invoke-Command -ComputerName  $ser -ScriptBlock { (Get-Item "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters").getValue("HostName") } 
    $cool
    }
    }
    
}


#Invoke-Command -ComputerName wmiibd01ocb.cfs.betasys.com -ScriptBlock { (Get-Item "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters").getValue("HostName") }


