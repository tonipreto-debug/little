$path = (Get-Location).Path + '\js\translations.js'
# Read as UTF-8 (the file is now UTF-8 after the previous script saved it)
$text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

Write-Host "ticker_2 occurrences before:"
[regex]::Matches($text, '"ticker_2":\s*"[^"]*"') | ForEach-Object { Write-Host $_.Value }

# Replace any version of CADA MES ... TICA with the clean ASCII version
$text = [regex]::Replace($text, '"ticker_2":\s*"CADA MES CAMBIAMOS DE TEM[^"]*TICA"', '"ticker_2": "CADA MES CAMBIAMOS DE TEMATICA"')

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($path, $text, $utf8NoBom)
Write-Host "Done"

Write-Host "ticker_2 occurrences after:"
Select-String -Path $path -Pattern "ticker_2" | ForEach-Object { $_.Line.Trim() }
