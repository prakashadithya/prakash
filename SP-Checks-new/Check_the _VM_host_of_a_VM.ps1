

Invoke-Command -ComputerName BPTNRCWEB01OCB -ScriptBlock { (Get-Item "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters").getValue("HostName") }


