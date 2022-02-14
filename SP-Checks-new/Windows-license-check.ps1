$Servers = Get-Content -path C:\prakash2.txt

<#
$Serv1 = Read-Host -Prompt "ENTER Hyper-V hosts TXT FILE:"
$servers = Get-Content $serv1

#>

foreach($servername in $servers)

{

$status = Invoke-Command -ComputerName  $servername -ScriptBlock {Get-CimInstance SoftwareLicensingProduct -Filter "Name like 'Windows%'" | where { $_.PartialProductKey } | select LicenseStatus } -ErrorAction SilentlyContinue 
if ($status.LicenseStatus -eq '1')
    {Write-Host $servername SERVER IS LICENSED } 
    Elseif ($status.LicenseStatus -eq '5')
    {Write-Host "$servername NOT LICENSED" -ForegroundColor Red}
    Elseif ($status = $Error[0])
    {Write-Host $servername NOT CONNECTING -ErrorAction SilentlyContinue -ForegroundColor DarkYellow}
     
}

