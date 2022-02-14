
    $Servers = Get-Content -path C:\prakash.txt
    
    foreach($server in $servers)
    {
    Invoke-Command -ComputerName  $server -ScriptBlock {iisreset}
    "$Server"
    }

