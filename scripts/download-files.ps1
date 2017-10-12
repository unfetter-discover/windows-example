# getfilesonguest.psi
# This powershell code will download, if necessary, Sysmon and NXLog for provisioning

$proxy = [System.Net.WebRequest]::GetSystemWebProxy()
$proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials


# Setup strings and variables
$DestDir = "c:\vagrant\resources\"
$SysmonExe = $DestDir+"Sysmon.exe"
$SysmonZip = $DestDir+"Sysmon.zip"

$NxLogMsi = $DestDir+"nxlog-ce-2.9.1504.msi"

New-Item -Force -ItemType directory -Path $DestDir

$SourceSysmon = "https://download.sysinternals.com/files/Sysmon.zip"
$SourceNxLog = "https://nxlog.co/system/files/products/files/1/nxlog-ce-2.9.1716.msi"

$wc = New-Object System.Net.WebClient
$wc.proxy = $proxy
# Get Sysmon

$FileExists = Test-Path $SysmonExe
If ($FileExists -eq $False) 
{
	$FileExists = Test-Path $SysmonZip 
	If ($FileExists -eq $False)
	{
		$wc.DownloadFile($SourceSysmon, $SysmonZip)
	}
	mkdir \tmp\sysmon

	cp C:\vagrant\resources\sysmon.zip \tmp\sysmon
	$shell = new-object -com shell.application
	$zip = $shell.NameSpace("C:\tmp\sysmon\Sysmon.zip")

	foreach($item in $zip.items())
	{
		$shell.Namespace("C:\tmp\sysmon").copyhere($item)

	}
	cp C:\tmp\sysmon\sysmon.exe $DestDir
	Remove-Item -Recurse -Force "c:\tmp\sysmon"

}

# Get NXlog
$FileExists = Test-Path $NxLogMsi
If ($FileExists -eq $False) {$wc.DownloadFile($SourceNxLog, $NxLogMsi)}
 




























$NeedFileSysmon = "C:\vagrant\resources\Sysmon.exe" 
$NeedFileNxLog = "C:\vagrant\resources\nxlog-ce-2.9.1504.msi"
$sourceSysmon = "https://download.sysinternals.com/files/Sysmon.zip"
$sourceNxLog = "https://nxlog.co/system/files/products/files/1/nxlog-ce-2.9.1504.msi"


$destsys = "C:\vagrant\resources\Sysmon.zip"
$destnx = "C:\vagrant\resources\nxlog-ce-2.9.1504.msi"
$dest = "C:\vagrant\resources\"



