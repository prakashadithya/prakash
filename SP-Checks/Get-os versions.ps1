workflow get-OsVersion

{

param( [string[]]$Computers )

  foreach -parallel ($computer in $computers)

  {

    if((Test-Connection -Cn $computer -BufferSize 16 -Count 1 -ea 0 -quiet))

        {

        $OS = (Get-WmiObject -Computer $computer -Class Win32_OperatingSystem ).caption

          "$computer $os"

          }        

          Else { "$computer  - not responding or found" }

  }

}

get-OsVersion -computers (get-content "c:\prakash.txt")