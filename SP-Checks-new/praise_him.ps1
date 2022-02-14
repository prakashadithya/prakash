$out1 =

Invoke-Command -ComputerName BLWLWEB01OCB -ArgumentList ($out1) -ScriptBlock { Import-Module WebAdministration;

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
Add-Content C:\prakashp\IIS-Output\iis.txt -value " "; Add-Content -path C:\prakashp\IIS-Output\iis.txt "$out1"