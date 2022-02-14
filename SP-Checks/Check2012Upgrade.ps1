$Servers = Get-Content .\Serverlist.txt

ForEach ($server in $servers)
{
    If ($null -eq $server -or $server -eq "")
    {
        Continue
    }

    Write-Host "$server".ToUpper()

    If (!(Test-Connection $server -Count 1 -Quiet))
    {
        Write-Host "This server cannot be reached" -BackgroundColor DarkRed -ForegroundColor Black
        Write-Host ""
        Write-Host "==========================================================================="
        Continue
    }

    # Check for .Net version
    $netver = Invoke-Command -Computername $server -ScriptBlock { (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full').Release }
    If ($netver -ge 461814 -and $server -match "web" -and !($server -match "webstr"))
    {
        Write-Host ".Net Version 4.7.2 Is Installed" -BackgroundColor DarkGreen -ForegroundColor Black
    }
    elseif ($netver -ge 393295 -and (!($server -match "web") -or ($server -match "webstr")))
    {
        Write-Host ".Net Version 4.6.1 Is Installed" -BackgroundColor DarkGreen -ForegroundColor Black
    }
    else
    {
        Write-Host "The proper version of .Net is not installed" -BackgroundColor DarkRed -ForegroundColor Black
    }

    # Check that Windows.OLD is deleted
    $winold = Invoke-Command -Computername $server -ScriptBlock { Test-Path "C:\Windows.old" }
    if (!($winold))
    {
        Write-Host "Windows.OLD Folder was deleted" -BackgroundColor DarkGreen -ForegroundColor Black
    }
    else
    {
        Write-Host "Windows.OLD Folder was not deleted" -BackgroundColor DarkYellow -ForegroundColor Black
    }

    # Check that offline patches are deleted
    $winold = Invoke-Command -Computername $server -ScriptBlock { Test-Path "C:\temp\client_2012R2" }
    if (!($winold))
    {
        Write-Host "Offline Patches Folder was deleted" -BackgroundColor DarkGreen -ForegroundColor Black
    }
    else
    {
        Write-Host "Offline Patches Folder was not deleted, delete C:\temp\client_2012R2\" -BackgroundColor DarkYellow -ForegroundColor Black
    }

    # Check if services are running
    $services = (Get-Service -Name * -Computername $server | Where-Object { $_.DisplayName -match "TTS" } | Select-Object -Property Status, DisplayName, StartType)
    ForEach ($service in $services)
    {
        If ($service.Status -eq "Running")
        {
            Write-Host "$( $service.DisplayName ) is Running" -BackgroundColor DarkGreen -ForegroundColor Black
        }
        else
        {
            if ($service.StartType -eq "Automatic")
            {
                Write-Host "$( $service.DisplayName ) is Not Running" -BackgroundColor DarkRed -ForegroundColor Black
            }
            else
            {
                Write-Host "$( $service.DisplayName ) is Not Running, but start type is $( $service.StartType )" -BackgroundColor DarkYellow -ForegroundColor Black
            }
        }
    }

    # Check for aspnetcore.dll
    If ($server -match "web" -and !($server -match "webstr"))
    {
        If (Test-Path "\\$server\C$\Windows\SysWOW64\inetsrv\aspnetcore.dll" -PathType Leaf)
        {
            Write-Host "ASP.Net Core x64 Runtime is installed" -BackgroundColor DarkGreen -ForegroundColor Black

        }
        else
        {
            Write-Host "ASP.Net Core x64 Runtime is missing" -BackgroundColor DarkRed -ForegroundColor Black
        }
        # Check if all the Application pools are running
        $poolstat = Invoke-Command -Computername $server -ScriptBlock { Import-Module WebAdministration; Get-WebAppPoolState | Where-Object { $_.Value -ne "Started" } }
        if ($null -eq $poolstat)
        {
            Write-Host "All Web Application pools are started" -BackgroundColor DarkGreen -ForegroundColor Black
        }
        else
        {
            $notrunning = $poolstat.count
            Write-Host "$notrunning Web Application pools are not running" -BackgroundColor DarkRed -ForegroundColor Black
        }
    }



    # Check if Windows is Activated
    $activate = Invoke-Command -Computername $server -ScriptBlock { (Get-CimInstance -ClassName SoftwareLicensingProduct -Filter "Name like 'Windows%'" | where PartialProductKey).licensestatus }
    if ($activate -eq "1")
    {
        Write-Host "Windows is Activated" -BackgroundColor DarkGreen -ForegroundColor Black
    }
    else
    {
        Write-Host "Windows is NOT Activated" -BackgroundColor DarkRed -ForegroundColor Black
    }

    # Check how many updates have been installed
    $patches = Invoke-Command -Computername $server -ScriptBlock { (wmic qfe list).count }
    if ($patches -gt "350")
    {
        Write-Host "$patches patches have been installed" -BackgroundColor DarkGreen -ForegroundColor Black
    }
    elseif ($patches -gt "200")
    {
        Write-Host "$patches patches have been installed" -BackgroundColor DarkYellow -ForegroundColor Black
    }
    else
    {
        Write-Host "$patches patches have been installed" -BackgroundColor DarkRed -ForegroundColor Black
    }

    # Check how many updates have been installed
    $SearchResult = Invoke-Command -Computername $server -ScriptBlock {
        $Searcher = New-Object -ComObject Microsoft.Update.Searcher
        $Searcher.Search("IsInstalled=0").Updates
    }
    $PatchCount = $SearchResult.count
    if ($PatchCount -eq 0)
    {
        Write-Host "No patches found to install" -BackgroundColor DarkGreen -ForegroundColor Black
    }
    elseif ($PatchCount -gt 50)
    {
        Write-Host "$PatchCount patches are waiting to be installed" -BackgroundColor DarkRed -ForegroundColor Black
    }
    else
    {
        Write-Host "$PatchCount patches are waiting to be installed" -BackgroundColor DarkYellow -ForegroundColor Black
    }

    Write-Host ""
    Write-Host "==========================================================================="
}
