
<#

$Serv1 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
$servers = Get-Content $serv1

#>

$Servers = Get-Content -path C:\prakash.txt

    foreach($servername in $Servers){

    foreach ($ser in $servername ){
 
    #Write-Output "------------------$ser---------------------"  | out-file C:\software_version.txt -Append
    $cool = Invoke-Command -ComputerName  $ser -ScriptBlock { Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* ; Get-ItemProperty HKLM:\Software\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\*} | Select-Object @{Name = "Server"; Expression={$ser}}, DisplayName, DisplayVersion | Where-Object { $_.DisplayName -like "FireEye*"}
    $cool 
    }
    
}


