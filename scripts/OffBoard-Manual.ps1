dsregcmd
dsregcmd /leave

Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CDJ"
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CDJ"

Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"

DisablePasswordChange : 0
MaximumPasswordAge    : 30
RequireSignOrSeal     : 1
RequireStrongKey      : 1
SealSecureChannel     : 1
ServiceDll            : C:\WINDOWS\system32\netlogon.dll
SignSecureChannel     : 1
Update                : no

$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CDJ",
    "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters",
    "HKLM:\SOFTWARE\Microsoft\Enrollments",
    "HKLM:\SOFTWARE\Microsoft\EnterpriseDesktopAppManagement",
    "HKLM:\SOFTWARE\Microsoft\PolicyManager",
    "HKLM:\SOFTWARE\Microsoft\Provisioning",
    "HKLM:\SOFTWARE\Microsoft\DeviceReg"
)
foreach ($path in $registryPaths) {
    Write-Host "`nChecking: $path" -ForegroundColor Cyan
    if (Test-Path $path) {
        Get-ItemProperty -Path $path | Format-List
    } else {
        Write-Host "Key not found." -ForegroundColor Red
    }
}
