<#

MANUAL INSTALLATION PATH : 

\\cfsfs1\media\FireEye installables\IMAGE_HX_AGENT_WIN_29.7.9 (1)

MANUAL CHECK :
 
Get-ItemProperty HKLM:\Software\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Where-Object { $_.DisplayName -like "Fire*"}

$Serv1 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
$servers = Get-Content $serv1

#>

$Servers = Get-Content -path C:\prakash.txt

    foreach($servername in $Servers){
    $Pingcheck= Test-Connection -ComputerName $servername -count 1 -Quiet

    if($Pingcheck -eq "true")
    {
    

    foreach ($ser in $servername ){
 
    #Write-Output "------------------$ser---------------------"  | out-file C:\software_version.txt -Append
    $cool = Invoke-Command -ComputerName  $ser -ScriptBlock {Get-ItemProperty HKLM:\Software\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\*} | Select-Object DisplayName, DisplayVersion, @{Name = "ServerName - Agent "; Expression={$ser}} | Where-Object { $_.DisplayName -like "FireEye*"}
    $cool
    }
    }
    
}


<#


BLSTH1A - Unable to login




#>