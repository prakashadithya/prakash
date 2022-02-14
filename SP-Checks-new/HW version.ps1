

$serv = Get-Content C:\Prakash.txt


foreach ($server in $serv)
{
    Invoke-Command -ComputerName  $server -ScriptBlock { Get-WmiObject win32_computersystem }
}