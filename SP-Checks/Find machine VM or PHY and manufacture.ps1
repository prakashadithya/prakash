

$Servers = Get-Content -path C:\prakash1.txt

    foreach($servername in $Servers){
    $Pingcheck= Test-Connection -ComputerName $servername -count 1 -Quiet

    if($Pingcheck -eq "true")
    {
    

    foreach ($ser in $servername ){
 
    #Write-Output "------------------$ser---------------------"  | out-file C:\software_version.txt -Append
    Get-WmiObject -ComputerName $ser win32_computersystem | select Name, Manufacturer, Model
    }
    }
    
}







#Get-WmiObject -ComputerName TSA2 win32_computersystem
