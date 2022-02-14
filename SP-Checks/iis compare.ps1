$Servers = Get-Content -path C:\Prakash.txt

    foreach($servername in $Servers){
    $Pingcheck= Test-Connection -ComputerName $servername -count 1 -Quiet

    if($Pingcheck -eq "true")
    {
    

    foreach ($ser in $servername ){
    
    Write-Output "------------------------------$ser--------------------------------------- "
    $content1 = Get-Content C:\prakashp\IIS-Output\today\iis_$ser.txt
    $content2 = Get-Content C:\prakashp\IIS-Output\postcheck\iis_$ser.txt



    #COPY PASTE BEFORE THAT

    $Diff = Compare-Object $content2 $content1

    $Diff
    
  }
   
    }
    
}


