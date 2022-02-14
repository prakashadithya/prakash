

$Servers = Get-Content -path C:\prakash.txt

foreach($servername in $servers)
{


$UserExistsWMI = [bool](Get-WMIObject -ClassName Win32_UserAccount -Computername $servername | Where-Object Name -eq 'prakashadithya')
 
    if(-not ($UserExistsWMI)){
 
     Write-Output "user doesnt exist"
 
    }
 
else{
    Write-Output "user already exists"
    
}
}

