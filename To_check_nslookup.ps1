﻿Get-Content C:\prakashp\ipaddress.txt | foreach {nslookup $_} | Out-file C:\prakashp\ipaddress_output.txt