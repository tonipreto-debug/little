## Fix for translations.js encoding corruption
# The file went through multiple encoding passes (Latin1 -> UTF8 -> Latin1 -> UTF8)
# causing characters to be encoded 2-3x. We need to undo this.

$path = (Get-Location).Path + '\js\translations.js'

# Read as UTF-8 (it was last saved as UTF-8)
$text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# Check the current state of a known troubled value
Write-Host "BEFORE:"
[regex]::Matches($text, '"footer_designed":\s*"[^"]*"') | ForEach-Object { Write-Host $_.Value.Substring(0, [Math]::Min(80, $_.Value.Length)) }

# The string "DiseÃƒÂ±ado" means:
# D-i-s-e = ASCII
# Ãƒ = UTF8 bytes C3 83 decoded as ISO-8859-1 -> gives "Ã" (UTF8 C3 83 = U+00C3, Ã)
# Â± = UTF8 bytes C2 B1 decoded as ISO-8859-1 -> gives "±" 
# But "Diseñado" = D-i-s-e-U+00F1-a-d-o
# UTF8 of ñ = C3 B1
# So Latin-1 literal: Ã (C3) ± (B1) -> = ñ in UTF-8

# Strategy: for each known triple-encoded sequence, convert step by step
# Simpler: convert the text bytes via Windows-1252 decoding twice

$bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
$step1 = [System.Text.Encoding]::GetEncoding(28591).GetString($bytes)  # Latin-1 decode
$bytes2 = [System.Text.Encoding]::GetEncoding(28591).GetBytes($step1)  # Re-encode as Latin-1
$step2 = [System.Text.Encoding]::UTF8.GetString($bytes2)               # Decode as UTF-8

Write-Host ""
Write-Host "AFTER (2-pass decode):"
[regex]::Matches($step2, '"footer_designed":\s*"[^"]*"') | ForEach-Object { Write-Host $_.Value.Substring(0, [Math]::Min(80, $_.Value.Length)) }

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($path, $step2, $utf8NoBom)
Write-Host "Saved."
