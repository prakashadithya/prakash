$SrvNames = Get-Content -Path 'C:\prakash.txt'

 

foreach ($Server in $SrvNames)

{

       Get-Service -Name BES* -ComputerName $Server | Stop-Service -PassThru | Set-Service -StartupType disabled
       Write-Host "$Server is stopped and disabled" -ForegroundColor Green
       

}