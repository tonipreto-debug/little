$path = "js\translations.js"

# Read as raw bytes
$bytes = [System.IO.File]::ReadAllBytes($path)

# Decode as Latin-1 (ISO-8859-1) to preserve original byte values
$latin1 = [System.Text.Encoding]::GetEncoding(28591)
$text = $latin1.GetString($bytes)

# Check a sample
Write-Host "Sample before fix:"
$text | Select-String "ticker_2" | Select-Object -First 3

# Replace the broken string: in Latin-1, Á = byte 0xC1, so "TEMÁTICA" = "TEMÁTICA" in Latin-1
# The text currently reads "TEMÃTICA" which in Latin-1 is Ã followed by T-I-C-A
# We need it to be Á which in Latin-1 is a single byte 0xC1
$text = $text -replace "CADA MES CAMBIAMOS DE TEM.TICA", "CADA MES CAMBIAMOS DE TEM`u00C1TICA"

Write-Host "Sample after fix:"
$text | Select-String "ticker_2" | Select-Object -First 3

# Write back as UTF-8 without BOM
$utf8 = New-Object System.Text.UTF8Encoding($false)
$outPath = (Get-Location).Path + "\js\translations.js"
[System.IO.File]::WriteAllText($outPath, $text, $utf8)

Write-Host "Done"
