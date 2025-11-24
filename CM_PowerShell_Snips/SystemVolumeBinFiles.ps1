<#
#Seems to be broken on Windows 11 22H2 - Need more testers to confirm.
- Works fine if you don't use ISE :-)

#Should return a list of BIN files on your System Volume
#>
# In windows 11 ver 24H2 - the Get-Volume command returns filesystem like this "FAT" since in the code you specified only "FAT32" it will not work. probeblx it's better to change it to $_.FileSystemType -contains "FAT" with this change it worked for me.
$Volume = Get-Volume | Where-Object {$_.FileSystemType -eq "FAT32" -and $_.DriveType -eq "Fixed"}
$SystemDisk = Get-Disk | Where-Object {$_.IsSystem -eq $true}
$SystemPartition = Get-Partition -DiskNumber $SystemDisk.DiskNumber | Where-Object {$_.IsSystem -eq $true}  
$SystemVolume = $Volume | Where-Object {$_.UniqueId -match $SystemPartition.Guid}
$BinFiles = Get-ChildItem -LiteralPath $SystemVolume.path -Recurse | Where-Object {$_.name -match "bin"}
$BinFiles
#$BinFiles | Remove-Item

$FontFolder = Get-ChildItem -LiteralPath $SystemVolume.path -Recurse | Where-Object {$_.name -match "Font"}
$FontFolder | Get-ChildItem
#$FontFolder | Get-ChildItem | Remove-Item -Force
