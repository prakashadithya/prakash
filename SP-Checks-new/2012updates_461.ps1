# Function to determine if .Net 4.6.1 is installed

Function IsInstalled {
    $ver = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full').Release
    return (!($ver -eq $null) -and ($ver -ge 393295))
}


# Function to handle reboots and continue script

Function ReallyReboot {
    shutdown /r /t 0
}


# Check if running as Admin

if ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  Write-Output "Elevated."
}
else
{
  Write-Output "Not elevated."
  Write-Output "Please re-launch the script as Administrator."
  Pause
  Exit
}
# Send message to the Teams Chat with update on progress

Write-Output "If you want to install offline updates, press ENTER, otherwise press any other key"

$key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

if ($key.VirtualKeyCode -eq "13")
{

    # Check if updates were started
    $path = "Z:\client_2012R2\Update.cmd"

    Start-Process -FilePath "\\cfsfs1\media\_2012R2 Upgrade Files\DeleteWindows.old.cmd"

    If (!(Test-Path $path -PathType Leaf))
    {
        net use z: "\\cfsfs1\media\_2012R2 Upgrade Files\client_2012R2"
    }

    Set-Location "Z:\"
    Write-Output "Installing updates."

    Start-Process -FilePath "Z:\cmd\DoUpdate.cmd" -Wait -WorkingDirectory "Z:\cmd" -NoNewWindow

    Write-Output "If updates were installed, press ENTER to reboot, otherwise press ESC to continue"

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    if ($key.VirtualKeyCode -eq "13")
    {
        ReallyReboot
    }
}

Write-Output "To attempt .NET 4.6.1 Install, Press ENTER, otherwise press any other key."

$key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
if ($key.VirtualKeyCode -eq "13")
{
    if (!(IsInstalled)){
        $net461 ='\\bltccode1\devinstalls\NDP461-KB3102436-x86-x64-AllOS-ENU.exe';
        $silentArgs = "/Passive  /showfinalerror /NoRestart /Log ""$env:temp\net46.log""";
        & cmd.exe /C "$net461 $silentArgs";
        Write-Output ".Net Version 4.6.1 installed, Press ENTER to reboot, Close window to exit."
        Pause
        ReallyReboot
    } else {
        Write-Output ".Net Version 4.6.1 already installed."
    }

}

Write-Output "To activate Windows and finish the script, press ENTER, otherwise press any other key"

$key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

if ($key.VirtualKeyCode -eq "13")
{
    # Activate Windows

    Write-Output "Activating Windows"
    slmgr.vbs -ipk PNFHR-8WBWH-C6WHY-J9723-T6K8W

    # Send message to the Teams Chat with update on progress

    Send-MailMessage -To "Status Updates - OS Upgrade Project <8d0ede9f.refinitiv.onmicrosoft.com@amer.teams.ms>" -from "michael.lieven@refinitiv.com"  -SmtpServer bn0.betasys.com -Subject ("Update.cmd finished on {0}" -f $env:COMPUTERNAME) -Body "client_2012r2 update.cmd has finished."

    Write-Output ""
    Write-Output ".Net 4.6.1 Installed: $(IsInstalled)"
    Write-Output "Script is completed"
    Pause
}