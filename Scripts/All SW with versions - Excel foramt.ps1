########################################################################################
#                     Scrpit to check all Third party software                         #
########################################################################################

$Serv1 = Read-Host -Prompt "ENTER THE PRE-CHECK FILES PATH:"
$servers = Get-Content $serv1



#$Servers = Get-Content -path C:\prakash.txt

Function Find-service
{

    foreach($servername in $Servers){

    foreach ($ser in $servername ){
 
    #Write-Output "------------------$ser---------------------"  | out-file C:\software_version.txt -Append
    $cool = Invoke-Command -ComputerName  $ser -ScriptBlock { Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* ; Get-ItemProperty HKLM:\Software\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\*} | Select-Object @{Name = "Server"; Expression={$ser}}, DisplayName, DisplayVersion | Where-Object { $_.DisplayName -like "IBM BigFix*"}
    $cool 
    }
    
}
}

Find-service | ConvertTo-Csv -NoTypeInformation -Delimiter "," | % {$_ -replace '"',''} | Out-File C:\Powershell_Scripts\Outputs\sw_csv.csv

#$a = Import-Csv C:\Powershell_Scripts\Outputs\Software_version\sw_csv.txt

$a = Find-service

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

$b | Export-Csv C:\Powershell_Scripts\Outputs\sw_excel.csv -NoTypeInformation
