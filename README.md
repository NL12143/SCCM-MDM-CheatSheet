# SCCM-MDM-CheatSheet

dsregcmd /status
Detailed report on:
Azure AD join status
Domain join status
MDM enrollment
SSO state


MDM CSP 


OCPS
The Office Cloud Policy Service (OCPS) is a Microsoft 365 feature that lets administrators manage Office app settings for users directly from the cloud — without needing on-prem Group Policy or device management tools like Intune.

🧭 What it does
Applies policies to Office apps (Word, Excel, Outlook, etc.) across Windows, macOS, and even web versions.
Targets users based on Azure AD identity, not device.
Works even if the device is not domain-joined or not enrolled in Intune.
Policies are enforced when the user signs into Office with their Microsoft 365 account.

🔧 Examples of what it can configure
Disable macros or VBA
Set default save locations (OneDrive, SharePoint)
Control telemetry and privacy settings
Enable or disable Loop components (like the registry keys you found)
Force specific update channels or versions
