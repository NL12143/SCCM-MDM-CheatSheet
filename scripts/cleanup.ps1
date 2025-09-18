dsregcmd /status
dsregcmd /leave

Get-WmiObject -Namespace "root\cimv2\mdm\dmmap" -Class "MDM_Policy_Config01_Connectivity01"
Get-WmiObject -Namespace "root\cimv2\mdm\dmmap" -Class MDM_Enrollment | ForEach-Object {
  $_.Delete()
}

Task Scheduler > Microsoft > Windows > EnterpriseMgmt
  PushLaunch   %windir%\system32\deviceenroller.exe
  PushUpgrade  $(@%systemRoot%\system32\deviceenroller.exe,-104)

Explorer C:\Windows\Logs\DeviceManagement\OMADMLog.xml

That will be remains in Edge, Defender, ... 
Intune and Azure AD leave traces beyond just the OS registry. Apps like Microsoft Edge, Defender for Endpoint, and others can retain policies, extensions, and configuration profiles even after unenrollment. Here's how to clean up those remnants:

🧹 Removing Intune Remnants from Edge, Defender, and More

🧭 1. Microsoft Edge

Edge may retain:
Pre-installed extensions
Policy-enforced settings (e.g., homepage, tracking protection)

Enterprise sync profiles
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
Get-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Edge"



🛡️ 2. Microsoft Defender for Endpoint
Defender may retain:
Endpoint onboarding scripts
Tamper protection settings
Legacy threat indicators

.\WindowsDefenderATPOffboardingScript.cmd
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"


$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CDJ",
    "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters",
    "HKLM:\SOFTWARE\Microsoft\Enrollments",
    "HKLM:\SOFTWARE\Microsoft\EnterpriseDesktopAppManagement",
    "HKLM:\SOFTWARE\Microsoft\PolicyManager",
    "HKLM:\SOFTWARE\Microsoft\Provisioning",
    "HKLM:\SOFTWARE\Microsoft\DeviceReg",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"
)

foreach ($path in $registryPaths) {
    Write-Host "`nChecking: $path" -ForegroundColor Cyan
    if (Test-Path $path) {
        Get-ItemProperty -Path $path | Format-List
    } else {
        Write-Host "Key not found." -ForegroundColor Red
    }
}

foreach ($path in $paths) {
  if (Test-Path $path) {
    Remove-Item -Path $path -Recurse -Force
  }
}
