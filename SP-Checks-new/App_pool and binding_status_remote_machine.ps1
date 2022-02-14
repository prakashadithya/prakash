
Invoke-Command -ComputerName  BLWLWEB01OCB -ScriptBlock { Import-Module WebAdministration; Get-ChildItem -Path IIS:\SSLBindings | ForEach-Object -Process `
{
    if ($_.Sites)
    {
        $certificate = Get-ChildItem -Path CERT:LocalMachine/My |
            Where-Object -Property Thumbprint -EQ -Value $_.Thumbprint

        [PsCustomObject]@{
            Sites                        = $_.Sites.Value
            CertificateFriendlyName      = $certificate.FriendlyName
            SSLCertificateName           = $certificate.DnsNameList
            CertificateNotAfter          = $certificate.NotAfter
            CertificateIssuer            = $certificate.Issuer
        } 
    }  
}
} | Out-File C:\prakashp\IIS-Output\iis.txt

Add-Content C:\prakashp\IIS-Output\iis.txt "------------------------------SSL CHECK (PORT AND BINDING) ------------------------------"


$out1 =

Invoke-Command -ComputerName BLWLWEB01OCB -ArgumentList ($out1) -ScriptBlock { Import-Module WebAdministration; Add-Content C:\prakashp\IIS-Output\iis.txt -value " "

Set-Location IIS:\SslBindings
$sslstatus = dir
foreach ($Port in $sslstatus)
{

$Portname = $Port.Port
$PathBinding = $port.PSParentPath
$out1 =  "The PORT NUMBER $Portname IS BINDED ON THE $PathBinding" 
$out1
}
} 
Add-Content C:\prakashp\IIS-Output\iis.txt -value " "; Add-Content -path C:\prakashp\IIS-Output\iis.txt "$out1"; Add-Content C:\prakashp\IIS-Output\iis.txt -value " "


Add-Content C:\prakashp\IIS-Output\iis.txt "------------------------------SSL CHECK (PORT AND BINDING) ------------------------------"; Add-Content C:\prakashp\IIS-Output\iis.txt -value " "

$out2 =

Invoke-Command -ComputerName BLWLWEB01OCB -ArgumentList ($out2) -ScriptBlock { Import-Module WebAdministration;Set-Location IIS:\Sites
$sitestatus = dir
foreach ($sites in $sitestatus)
{
$SiteName = $sites.Name
$SiteState = $sites.State
$out2 = " $SiteState : STATUS  SITENAME : $SiteName "
$out2
}
}
Add-Content C:\prakashp\IIS-Output\iis.txt -value " "; Add-Content -path C:\prakashp\IIS-Output\iis.txt "$out2"; Add-Content C:\prakashp\IIS-Output\iis.txt -value " "


Add-Content C:\prakashp\IIS-Output\iis.txt "-----------------------------APP POOL STATUS ------------------------------";Add-Content C:\prakashp\IIS-Output\iis.txt -value " "


$out3 =
Invoke-Command -ComputerName BLWLWEB01OCB -ArgumentList ($out3) -ScriptBlock {Import-Module WebAdministration; Set-Location IIS:\AppPools
$PoolStatus = dir
foreach ($pool in $PoolStatus)
{
$PoolName = $pool.Name      
$PoolStatus = $pool.State

$out3 =  " $PoolStatus - $PoolName " 
$out3
}
}
$out3 | Add-Content -path C:\prakashp\IIS-Output\iis.txt
 