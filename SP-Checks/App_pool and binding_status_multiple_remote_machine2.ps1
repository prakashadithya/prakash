
$Servers = Get-Content -path C:\prakash.txt

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
} | Out-File \\tsa2\prakashp\IIS-Output\iis_$servername.txt


Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt "------------------------------SSL CHECK (PORT AND BINDING) ------------------------------"


$out1 =

Invoke-Command -ComputerName $servername -ArgumentList ($out1) -ScriptBlock { Import-Module WebAdministration; Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt -value " "

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
Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt -value " "; $out1 | Add-Content -path \\tsa2\prakashp\IIS-Output\iis_$servername.txt ; Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt -value " "


Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt "------------------------------SSL CHECK (PORT AND BINDING) ------------------------------"; Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt -value " "

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
Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt -value " "; $out2 | Add-Content -path \\tsa2\prakashp\IIS-Output\iis_$servername.txt ; Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt -value " "


Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt "-----------------------------APP POOL STATUS ------------------------------";Add-Content \\tsa2\prakashp\IIS-Output\iis_$servername.txt -value " "


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
$out3 | Add-Content -path \\tsa2\prakashp\IIS-Output\iis_$servername.txt

}