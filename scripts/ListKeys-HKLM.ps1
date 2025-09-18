Get-ChildItem -Path "HKLM:\Software\Policies\" -Recurse | ForEach-Object {
    $keyPath = $_.PSPath
    $props = Get-ItemProperty -Path $_.PSPath
    foreach ($name in $props.PSObject.Properties.Name) {
        if ($name -ne "PSPath" -and $name -ne "PSParentPath" -and $name -ne "PSChildName" -and $name -ne "PSDrive" -and $name -ne "PSProvider") {
            [PSCustomObject]@{
                KeyPath   = $keyPath
                Property  = $name
                Value     = $props.$name
            }
        }
    }
} | Format-Table -AutoSize
