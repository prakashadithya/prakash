invoke-command -Scriptblock {get-process} -Computername "blwwrt01ocb","blwwrt02ocb","blwwrt03ocb","blwwrt04ocb","blwwrt05ocb","blwwrt06ocb","blwwrt07ocb","blwwrt08ocb","blwwrt01us1","blwwrt02us1","blwwrt03us1","blwwrt04us1","blwwrt05us1","blwwrt06us1","blwwrt07us1","blwwrt08us1" | Where-object {($_.name -like "RTBETAHOSTAccessSvr")} | format-table pscomputername,name,starttime