
#WMIC BIOS GET Manufacturer, SMBIOSBIOSVersion
#Get-WmiObject Win32_Computersystem

$Serv1 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
#$Servers = Get-Content -path C:\prakashp\services_host.txt
$servers = Get-Content $serv1

foreach($servername in $Servers){

    foreach ($ser in $servername ){
    Write-Output "------------------$ser---------------------"
    $cool = Invoke-Command -ComputerName $servername -ScriptBlock { Get-VMNetworkAdapter -all} 
    $cool | select VMName,IPAddresses}
    #$cool
    #
}  

###FOR SQL SERVICES####
#Get-WmiObject win32_Service -ComputerName blwqsqlg01ocb -Filter "DisplayName LIKE '%SQL%'" | select Caption, StartName, StartMode, State

###DISK MGMT####
#Get-WmiObject Win32_LogicalDisk -ComputerName blwqsqlg01ocb  -Filter DriveType=3 | Select-Object DeviceID, @{'Name'='Size (GB)'; 'Expression'={[math]::truncate($_.size / 1GB)}}, @{'Name'='Freespace (GB)'; 'Expression'={[math]::truncate($_.freespace / 1GB)}}


###NETWORK DETIALS####
#Invoke-Command -ComputerName blwqsqlg01ocb -ScriptBlock { Get-NetAdapter | select Name, InterfaceDescription, Status | Format-Table -AutoSize} 



Invoke-Command -ComputerName blwqsqlg01ocb -ScriptBlock {Get-PSDrive -PSProvider FileSystem} 

Invoke-Command -ComputerName blwqsqlg01ocb -ScriptBlock { Get-NetAdapter} 

Invoke-Command -ComputerName blwqsqlg01ocb -ScriptBlock {Get-PSDrive -PSProvider FileSystem} 



Get-WmiObject Win32_LogicalDisk -ComputerName blwqsqlg01ocb  -Filter DriveType=3 | Select-Object DeviceID, @{'Name'='Size (GB)'; 'Expression'={[math]::truncate($_.size / 1GB)}}, @{'Name'='Freespace (GB)'; 'Expression'={[math]::truncate($_.freespace / 1GB)}}

Get-NetworkAdapter -ComputerName blwqsqlg01ocb



Invoke-Command -ComputerName blwqsqlg01ocb -ScriptBlock { Get-NetAdapter | select Name, InterfaceDescription, Status | Format-Table -AutoSize} 




