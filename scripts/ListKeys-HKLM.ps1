
$HKLMpolicyKeys = Get-ChildItem -Path "HKLM:\Software\Policies\" -Recurse -ErrorAction SilentlyContinue

Get-Item -Path "HKLM:\Software\Policies\Microsoft\Edge"
Get-Item -Path "HKLM:\Software\Policies\Microsoft\Edge" | select Property

#LIST ALL POLICY REGKEYS
foreach ($key in $HKLMpolicyKeys) {
    $keyPath = $key.PSPath -replace "Microsoft\.PowerShell\.Core\\Registry::", ""
    Write-Host "$keyPath" -ForegroundColor Cyan
}

foreach ($key in $HKLMpolicyKeys) {
    $rawPath = $key.PSPath
    $cleanPath = $rawPath -replace "Microsoft\.PowerShell\.Core\\Registry::HKEY_LOCAL_MACHINE\\Software\\Policies\\", ""
    Write-Host "$cleanPath" -ForegroundColor Cyan
    try {
        $props = Get-ItemProperty -Path $rawPath -ErrorAction Stop
        foreach ($prop in $props.PSObject.Properties) {
            if ($prop.Name -notmatch "^PS") {
                $value = $prop.Value
                if ($value -is [System.Collections.IEnumerable] -and !$value.GetType().IsPrimitive -and $value -ne $null) {
                    $value = ($value -join ", ")
                }
                $valueStr = "$value"
                if ($valueStr.Length -gt 100) {
                    $valueStr = $valueStr.Substring(0, 100) + "..."
                }
                Write-Host "$($prop.Name) : $valueStr"
            }
        }
    } catch {
        Write-Host "⚠️ Could not read: $cleanPath" -ForegroundColor Yellow
    }
}

<# TRIAL RUNS 

Value 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows Advanced Threat Protection" -Name "OnboardingInfo"

Key + Value 
Remove-Item -Path "HKLM:\Software\Policies\Microsoft\Windows Advanced Threat Protection" -Recurse

foreach ($key in $policyKeys) {
    $rawPath = $key.PSPath
    $cleanPath = $rawPath -replace "Microsoft\.PowerShell\.Core\\Registry::HKEY_LOCAL_MACHINE\\Software\\Policies\\", ""
    Write-Host "$cleanPath" -ForegroundColor Cyan
    try {
        $props = Get-ItemProperty -Path $rawPath -ErrorAction Stop
        foreach ($prop in $props.PSObject.Properties) {
            if ($prop.Name -notmatch "^PS") {
                Write-Host "$($prop.Name) : $($prop.Value)"
            }
        }
    } catch {
        Write-Host "⚠️ Could not read: $cleanPath" -ForegroundColor Yellow
    }
}



foreach ($key in $policyKeys) {
    $keyPath = $key.PSPath
    Write-Host "`n--- $keyPath ---" -ForegroundColor Cyan
    try {
        $props = Get-ItemProperty -Path $keyPath -ErrorAction Stop
        foreach ($prop in $props.PSObject.Properties) {
            if ($prop.Name -notmatch "^PS") {
                Write-Host "$($prop.Name) : $($prop.Value)"
            }
        }
    } catch {
        Write-Host "⚠️ Could not read: $keyPath" -ForegroundColor Yellow
    }
}

#>
