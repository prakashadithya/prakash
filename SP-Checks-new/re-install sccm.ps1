
$Servers = Get-Content "C:\Prakash.txt"

$source = "\\sccm01ocb\SMS_150\Client\ccmsetup.exe"

$dest = "c$"

$testPath = "c$\ccmsetup.exe"


foreach($servername in $servers)
{ 
    if (Test-Connection -ComputerName $servername -Quiet) {

           
            Copy-Item $source -Destination \\$servername\$dest\ -Recurse -Force

            if (Test-Path -Path \\$servername\$testPath) {
                    
                    Invoke-Command -ComputerName $servername -ScriptBlock { powershell.exe C:\temp\ccmsetup.exe /mp:sccm01ocb /logon SMSSITECODE=AUTO }
                    Write-Host -ForegroundColor Green "Installed successful on $servername"
                    
                    }
                 
                } else {
                    Write-Host -ForegroundColor Red "$servername is not online, Install failed"
        
            }


        }