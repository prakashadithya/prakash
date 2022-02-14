Param($Sourcepath)

if (!(Test-Path -path $Sourcepath ))

{Write-Host "Required  files are missing in the file path"

            Exit(1)
}


$day = get-date -f dd-MM-yyyy-hh-mm-ss
$patchdate = Get-Date -format "MM/dd/yyyy HH:mm:ss"
$destinationFolder = "C:\Temp\$day"


if (!(Test-Path -path $destinationFolder))

{      New-Item $destinationFolder -Type Directory }

write-host "Destination folder created" -ForegroundColor Green

###### Before copying the files to destination , i want to to validate the files signature and it's extension at the source itself#######

<<need help here >>>

Copy-Item -Path "$Sourcepath\*.*" -Destination $destinationFolder -Force    

Write-Host "Files are copied to $destinationFolder" -ForegroundColor Green

expand -f:* $destinationFolder\*.*  $destinationFolder

write-host "Files expanded and extracted cab files" -ForegroundColor Green

Remove-Item $destinationFolder\*.msu

<<Need help here >>

dism.exe /online /add-package /packagepath:$destinationfolder /quiet /norestart 

Remove-item $destinationFolder\*.*

Get-HotFix |?{$_.InstalledOn -gt ((Get-Date).AddHours(-10))} | FT -AutoSize#


write-host "Reboot may required to finish the installation"