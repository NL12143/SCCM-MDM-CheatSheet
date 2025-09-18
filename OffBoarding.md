

dsregcmd.exe /debug /leave
This removes the device's Azure AD registration and clears associated SCP entries.

RegEdit 
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CDJ
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters


The official offboarding script for Microsoft Defender for Endpoint directly from Microsoft's documentation portal. 

🔗 Microsoft Defender for Endpoint: Offboard devices

🧭 Steps to get the offboarding script
Go to the Microsoft Defender portal: https://security.microsoft.com

Sign in with your admin credentials.

Navigate to:

Settings → Endpoints → Device management → Offboarding

Select your operating system (e.g., Windows 10/11).

Choose Local script as the deployment method.

Click Download offboarding package.

💡 The script is signed and time-limited — it typically expires after 30 days, so make sure to use it promptly.

WindowsDefenderATPOffboardingScript.cmd
Start-Process "WindowsDefenderATPOffboardingScript.cmd" -Verb RunAs


# Manual cleanup (not officially supported)

Remove-Item -Path "HKLM:\Software\Policies\Microsoft\Windows Advanced Threat Protection" -Recurse -Force
Remove-Item -Path "HKLM:\Software\Microsoft\Windows Advanced Threat Protection" -Recurse -Force

Get-Service -Name Sense
Stop-Service -Name Sense
Set-Service -Name Sense -StartupType Disabled
