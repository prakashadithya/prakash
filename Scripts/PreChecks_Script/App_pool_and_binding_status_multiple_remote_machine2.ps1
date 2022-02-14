$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
$Servers = Get-Content -path C:\Powershell_Scripts\Scripts\PreChecks_Script\Servers.txt

$path = "C:\Powershell_Scripts\Outputs\IIS\IIS-$date"

If (!(Test-Path $path))
{
New-Item -ItemType Directory -Path "C:\Powershell_Scripts\Outputs\IIS\IIS-$date"
}

foreach($servername in $servers)
{

Invoke-Command -ComputerName  $servername -ScriptBlock { Import-Module WebAdministration; Get-ChildItem -Path IIS:\SSLBindings | ForEach-Object -Process `
{
    if ($_.Sites)
    {
        $certificate = Get-ChildItem -Path CERT:LocalMachine/My |
            Where-Object -Property Thumbprint -EQ -Value $_.Thumbprint

        [PsCustomObject]@{
            SITES                        = $_.Sites.Value
            SSL_CERTIFICATE_NAME         = $certificate.DnsNameList
            CERTIFICATE_NOT_AFTER        = $certificate.NotAfter
            CertificateIssuer            = $certificate.Issuer
        } 
    }  
}
} | Out-File C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt


Add-Content C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt "------------------------------SSL CHECK (PORT AND BINDING) ------------------------------"


$out1 =

Invoke-Command -ComputerName $servername -ArgumentList ($out1) -ScriptBlock { Import-Module WebAdministration; Add-Content C:\Powershell_Scripts\Outputs\IIS\iis_$servername.txt -value " "

Set-Location IIS:\SslBindings
$sslstatus = dir
foreach ($Port in $sslstatus)
{

$Portname = $Port.Port
$PathBinding = $port.PSParentPath
$out1 =  "The PORT NUMBER - $Portname IS BINDED ON THE - $PathBinding" 
$out1
}
} 
Add-Content C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt -value " "; $out1 | Add-Content -path C:\Powershell_Scripts\Outputs\IIS\iis_$servername.txt ; Add-Content C:\Powershell_Scripts\Outputs\IIS\iis_$servername.txt -value " "


Add-Content C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt "------------------------------SSL CHECK (PORT AND BINDING) ------------------------------"; Add-Content C:\Powershell_Scripts\Outputs\IIS\iis_$servername.txt -value " "

$out2 =

Invoke-Command -ComputerName $servername -ArgumentList ($out2) -ScriptBlock { Import-Module WebAdministration;Set-Location IIS:\Sites
$sitestatus = dir
foreach ($sites in $sitestatus)
{
$SiteName = $sites.Name
$SiteState = $sites.State
$out2 = " $SiteState - STATUS  SITENAME - $SiteName "
$out2
}
}
Add-Content C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt -value " "; $out2 | Add-Content -path C:\Powershell_Scripts\Outputs\IIS\iis_$servername.txt ; Add-Content C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt -value " "


Add-Content C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt "-----------------------------APP POOL STATUS ------------------------------";Add-Content C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt -value " "


$out3 =
Invoke-Command -ComputerName $servername -ArgumentList ($out3) -ScriptBlock {Import-Module WebAdministration; Set-Location IIS:\AppPools
$PoolStatus = dir
foreach ($pool in $PoolStatus)
{
$PoolName = $pool.Name      
$PoolStatus = $pool.State

$out3 =  " $PoolStatus - $PoolName " 
$out3
}
}
$out3 | Add-Content -path C:\Powershell_Scripts\Outputs\IIS\IIS-$date\iis_$servername.txt

}