﻿invoke-command -Computername (Get-Content C:\Users\prakashpadmin\Desktop\SP-Checks\Servers.txt) -Scriptblock {Get-Service "PlugPlay" | sort-object status, MachineName}