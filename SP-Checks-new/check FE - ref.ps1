
<#

$Serv1 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
$servers = Get-Content $serv1

#>

$Servers = Get-Content -path C:\Prakash.txt

    foreach($servername in $Servers){

    foreach ($ser in $servername ){
 
    #Write-Output "------------------$ser---------------------"  | out-file C:\software_version.txt -Append
    get-wmiobject -class win32_product -computername $ser -filter { Name like "%FireEye Endpoint Agent%" } | Select-Object name, version, @{Name = "ServerName - Agent "; Expression={$ser}}
    
    }
    
}


