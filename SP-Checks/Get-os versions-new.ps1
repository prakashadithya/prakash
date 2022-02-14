
$ips = Get-Content -path C:\prakash.txt

ForEach ($ip in $ips) {

  $server = Get-WmiObject -comp $ip Win32_OperatingSystem

  New-Object PSObject -Property @{

    IP = $ip

    Hostname = $server.__Server

    OS = $server.caption

    Version = $server.Version

    }

 }