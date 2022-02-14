
$Serv1 = Read-Host -Prompt "ENTER THE FILES PATH:"
#$Servers = Get-Content -path C:\prakashp\services_host.txt
$servers = Get-Content $serv1

foreach($servername in $Servers)
{
   Copy-Item \\cfsfs1\media\Crowdstrike\6.30.14406\WindowsSensor.exe -Destination \\$servername\c$\temp\ -Recurse
   Invoke-Command -ComputerName $servername -ScriptBlock { psexec.exe -accepteula C:\temp\WindowsSensor.exe /install /quiet /norestart /log C:\ProgramData\CSLog\CsLog.txt CID=002D6304545344E49BE35814F83A1F74-EE ProvNoWait=1 APP_PROXYNAME=webproxy.global.mgmt.services APP_PROXYPORT=8081 ProvToken=6ACA9CFE GROUPING_TAGS="h_RFT,h_RFT_NONProd"} 
   
} 

