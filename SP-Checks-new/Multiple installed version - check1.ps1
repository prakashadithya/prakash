$Serv1 = Read-Host -Prompt "ENTER THE LIST OF SERVERS TEXT FILE:"
#$Servers = Get-Content -path C:\prakash.txt
$list = Get-Content $serv1

 
 foreach($PC in $list){
     Write-Output "------------------$PC---------------------" 
    Write-Output "------------------$PC---------------------"  | out-file C:\software_version.txt -Append
    $data = Get-WmiObject -ComputerName $PC -Class Win32_Product | sort-object Name |

Select-Object Name, Version | Where-Object { $_.Name -like "*Domain*" -or $_.name -like "*Corr*" -or $_.name -like "*Bigfix*" -or $_.name -like "*FireEye*" -or $_.name -like "*Mcafee*" -or $_.name -like "*NXlog*"}

    $data

    $data  | out-file C:\software_version.txt -Append
      
}