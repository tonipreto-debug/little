$path = "js\translations.js"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# Fix ticker_2 in all 5 languages - replace corrupted character with correct Á
$content = $content -replace '"ticker_2": "CADA MES CAMBIAMOS DE TEM.TICA"', '"ticker_2": "CADA MES CAMBIAMOS DE TEMÁTICA"'

# Write back as UTF8 with BOM to ensure browser reads it correctly
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Resolve-Path $path).Path, $content, $utf8NoBom)

Write-Host "Done. Occurrences fixed:"
Select-String -Path $path -Pattern "ticker_2"
