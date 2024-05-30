$Serialnumber = (Get-CimInstance -Class Win32_BIOS).SerialNumber
$Path = ($MyInvocation.MyCommand.Path -replace $MyInvocation.MyCommand.Name, "") + "AutoPilot-Export\"  
if (!(Test-Path $Path)) {
    New-Item -ItemType Directory -Path $Path
}
$FileName = $Serialnumber + "_Autopilot_Export.csv"
$FullPath = $Path + $FileName

# HardwareHash
$HardwareHash = (Get-CimInstance -Namespace root/CIMV2/mdm/dmmap -ClassName MDM_DevDetail_Ext01).DeviceHardwareData

# Create CSV
$output = [PSCustomObject]@{
    "Device Serial Number" = $Serialnumber;
    "Windows Product ID"   = "";
    "Hardware Hash"        = $HardwareHash
} 

if (!(Test-Path -Path $FullPath)) {
    $output | Export-Csv -LiteralPath $FullPath -Delimiter "," -Encoding utf8 -Force -NoTypeInformation 
}
else {
    $output | Export-Csv -LiteralPath $FullPath -Delimiter "," -Encoding utf8 -Force -Append 
}
