


$Serv1 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
$servers = Get-Content $serv1



#$Servers = Get-Content -path C:\prakash.txt

Function Find-service
{

    foreach($servername in $Servers){

    foreach ($ser in $servername ){
 
    #Write-Output "------------------$ser---------------------"  | out-file C:\software_version.txt -Append
    $cool = Invoke-Command -ComputerName  $ser -ScriptBlock { Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* ; Get-ItemProperty HKLM:\Software\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\*} | Select-Object @{Name = "Server"; Expression={$ser}}, DisplayName, DisplayVersion | Where-Object { $_.DisplayName -like "Domain Time Client*" -or $_.DisplayName -like "TrueSight*" -or $_.DisplayName -like "McAfee*" -or $_.DisplayName -like "IBM BigFix*" -or $_.DisplayName -like "CorreLog Syslog Message Service*" -or $_.DisplayName -like "FireEye*" -or $_.DisplayName -like "NXLog*" -or $_.DisplayName -like "UniversalForwarder*" -or $_.DisplayName -like "Configuration Manager Client*" -or $_.DisplayName -like "ASG*" -or $_.DisplayName -like "BMC*"}
    $cool 
    }
    
}
}

Find-service | ConvertTo-Csv -NoTypeInformation -Delimiter "," | % {$_ -replace '"',''} | Out-File C:\prakashp\test.txt

$a = Import-Csv C:\Prakashp\test.txt

$a | FT -AutoSize

 

$Duration = Measure-Command {

    $b = @()

    foreach ($Server in $a.Server | Select -Unique) {

        $Props = [ordered]@{ Server = $Server }

        foreach ($DisplayName in $a.DisplayName | Select -Unique){

            $Value = ($a.where({ $_.DisplayName -eq $DisplayName -and

                        $_.Server -eq $Server })).DisplayVersion

            $Props += @{ $DisplayName = $Value }

        }

        $b += New-Object -TypeName PSObject -Property $Props

    }

}


Write-Host "Finished transposing " -ForegroundColor Green -NoNewline
 

$b | FT -AutoSize

#$b | Out-GridView

$b | Export-Csv C:\software_version.csv -NoTypeInformation
