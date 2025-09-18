
$HKCUpolicyKeys = Get-ChildItem -Path "HKCU:\Software\Policies" -Recurse -ErrorAction SilentlyContinue

Get-Item -Path "HKCU:\Software\Policies\Power"
Get-Item -Path "HKCU:\Software\Policies\Cache" | select Property

#LIST ALL POLICY REGKEYS
foreach ($key in $HKCUpolicyKeys) {
    $keyPath = $key.PSPath -replace "Microsoft\.PowerShell\.Core\\Registry::", ""
    Write-Host "$keyPath" -ForegroundColor Cyan
}

#LIST ALL POLICY REGKEYS VALUES (skip blancs) 
foreach ($key in $HKCUpolicyKeys) {
    $rawPath = $key.PSPath
    try {
        $props = Get-ItemProperty -Path $rawPath -ErrorAction Stop
        $realProps = $props.PSObject.Properties | Where-Object { $_.Name -notmatch "^PS" }
        if ($realProps.Count -gt 0) {
            $cleanPath = $rawPath -replace "Microsoft\.PowerShell\.Core\\Registry::HKEY_CURRENT_USER\\Software\\Policies\\", ""
            Write-Host "$cleanPath" -ForegroundColor Cyan
            foreach ($prop in $realProps) {
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
        # silently skip unreadable keys
    }
}

<# TRIALS
LIST ALL POLICY REGKEYS VALUES 
foreach ($key in $HKCUpolicyKeys) {
    $rawPath = $key.PSPath
    $cleanPath = $rawPath -replace "Microsoft\.PowerShell\.Core\\Registry::HKEY_CURRENT_USER\\Software\\Policies\\", ""
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
#>
