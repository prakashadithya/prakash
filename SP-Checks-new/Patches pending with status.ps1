
$Serv1 = Read-Host -Prompt "ENTER THE LIST OF SERVERS TEXT FILE:"
#$Servers = Get-Content -path C:\prakash.txt
$servers = Get-Content $serv1

foreach($servername in $Servers){

    foreach ($ser in $servername ){
    Write-Host "----- TOTAL NUMBER OF PATCHES PENDING ON $ser --------"
    
        Invoke-Command -ComputerName $ser -ArgumentList ($Updates) -ScriptBlock {

        $UpdateSession = New-Object -ComObject Microsoft.Update.Session

        $UpdateSearcher = $UpdateSession.CreateupdateSearcher()

        $Updates = @($UpdateSearcher.Search("IsHidden=0 and IsInstalled=0").Updates)

        $Updates.Count
        Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate | select WUServer, WUStatusServer

        Write-Host "================================================================="

       }

       }
}


