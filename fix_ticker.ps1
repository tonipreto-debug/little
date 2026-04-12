$path = (Get-Location).Path + '\js\translations.js'
$enc1252 = [System.Text.Encoding]::GetEncoding(1252)
$bytes = [System.IO.File]::ReadAllBytes($path)
$text = $enc1252.GetString($bytes)

Write-Host "Total ticker_2 matches:" ([regex]::Matches($text, "ticker_2")).Count

# Replace all broken variants
$text = $text -replace '"ticker_2": "CADA MES CAMBIAMOS DE TEM.TICA"', '"ticker_2": "CADA MES CAMBIAMOS DE TEMATICA"'

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($path, $text, $utf8NoBom)
Write-Host "Saved as UTF-8 without BOM"

# Verify
Select-String -Path $path -Pattern "ticker_2" | ForEach-Object { $_.Line.Trim() }
