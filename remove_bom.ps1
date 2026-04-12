$path = (Get-Location).Path + '\js\translations.js'
$bytes = [System.IO.File]::ReadAllBytes($path)

Write-Host ('First bytes: ' + $bytes[0].ToString('X2') + ' ' + $bytes[1].ToString('X2') + ' ' + $bytes[2].ToString('X2'))

if ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    Write-Host 'UTF-8 BOM found. Removing...'
    $noBomBytes = New-Object byte[] ($bytes.Length - 3)
    [Array]::Copy($bytes, 3, $noBomBytes, 0, $bytes.Length - 3)
    [System.IO.File]::WriteAllBytes($path, $noBomBytes)
    Write-Host 'BOM removed successfully.'
} else {
    Write-Host 'No UTF-8 BOM at start. First byte decimal:' $bytes[0]
}
