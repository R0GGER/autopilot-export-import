$Serialnumber = (Get-CimInstance -Class Win32_BIOS).SerialNumber
$FileName = $Serialnumber + "_export.csv"
$HardwareHash = (Get-CimInstance -Namespace root/CIMV2/mdm/dmmap -ClassName MDM_DevDetail_Ext01).DeviceHardwareData

$output = [PSCustomObject]@{
    "Device Serial Number" = $Serialnumber;
    "Windows Product ID"   = "";
    "Hardware Hash"        = $HardwareHash
} 

$output | convertto-csv -NoTypeInformation -Delimiter "," | % {$_ -replace '"',''} | Out-File $FileName
