$files = Get-ChildItem -Path . -Filter "*.html"

foreach ($file in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    
    # Detect if file has BOM or is genuinely UTF-8 or Latin-1
    # If it was saved as Latin-1 (Win-1252) but has UTF-8 content (from our edits), 
    # it will have double-encoded characters like Ã¡ for á
    
    $latin1 = [System.Text.Encoding]::GetEncoding(1252)
    $text = $latin1.GetString($bytes)
    
    # Check if file has double-encoded characters (hallmark of Latin-1 file with UTF-8 chars)
    if ($text -match "Ã¡|Ã©|Ã³|Ãº|Ã±|Ã\u00a0|Ã\u0081|Ã\u0089|Ã\u0093|Ã\u009a") {
        Write-Host "Found encoding issues in: $($file.Name)"
        
        # These replacements convert the double-encoded UTF-8-in-Latin-1 back to correct UTF-8
        $text = $text -replace "Ã¡", "á"
        $text = $text -replace "Ã©", "é"
        $text = $text -replace "Ã³", "ó"
        $text = $text -replace "Ãº", "ú"
        $text = $text -replace "Ã±", "ñ"
        $text = $text -replace "Ã\u00a0", "à"
        $text = $text -replace "Ã­", "í"
        $text = $text -replace "Ã¼", "ü"
        $text = $text -replace "Ã\u00bc", "Ü"
        $text = $text -replace "â€"", "—"
        $text = $text -replace "â€™", "'"
        $text = $text -replace "â€œ", '"'
        $text = $text -replace "â€", '"'
        $text = $text -replace "Â¡", "¡"
        $text = $text -replace "Â¿", "¿"
        $text = $text -replace "Ã\u0081", "Á"
        $text = $text -replace "Ã\u0089", "É"
        $text = $text -replace "Ã\u009a", "Ú"
        $text = $text -replace "Ã\u0093", "Ó"
        $text = $text -replace "Ã\u0091", "Ñ"
        $text = $text -replace "Ã¨", "è"
        $text = $text -replace "Ã ", "à"
        $text = $text -replace "Ã\u00b9", "ù"
        $text = $text -replace "Ã\u00ae", "®"
        $text = $text -replace "Â·", "·"
        $text = $text -replace "Â«", "«"
        $text = $text -replace "Â»", "»"
        $text = $text -replace "Â©", "©"
        $text = $text -replace "Âº", "º"
        $text = $text -replace "Ãª", "ê"
        $text = $text -replace "Ã®", "î"
        $text = $text -replace "Ã¢", "â"
        $text = $text -replace "Ã"", "Â"
        $text = $text -replace "Ã\u00b4", "ô"
        $text = $text -replace "Ãƒ", "Ã"
        $text = $text -replace "â€¦", "…"
        $text = $text -replace "Â ", " "
        $text = $text -replace "Âª", "ª"
        $text = $text -replace "Â°", "°"
        $text = $text -replace "Ã¤", "ä"
        $text = $text -replace "Ã¶", "ö"
        $text = $text -replace "Ã¼", "ü"
        $text = $text -replace "Ã\u0084", "Ä"
        $text = $text -replace "Ã\u0096", "Ö"
        $text = $text -replace "Ã\u009c", "Ü"
        $text = $text -replace "Ã\u009f", "ß"
        $text = $text -replace "Ã§", "ç"
        $text = $text -replace "Ã\u0080", "À"
        $text = $text -replace "Ã\u0088", "È"
        $text = $text -replace "Ã\u008c", "Ì"
        $text = $text -replace "Ã\u0092", "Ò"
        $text = $text -replace "Ã\u00b2", "ò"
        $text = $text -replace "Ã ¬", "ì"
        $text = $text -replace "Ã¯", "ï"
        $text = $text -replace "Ã¥", "å"
        $text = $text -replace "Ã\u0085", "Å"
        $text = $text -replace "Ã¦", "æ"
        $text = $text -replace "Ã\u0086", "Æ"
        $text = $text -replace "Ã\u00b8", "ø"
        $text = $text -replace "Ã\u0098", "Ø"
        
        # Write back as UTF-8 without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file.FullName, $text, $utf8NoBom)
        Write-Host "  Fixed: $($file.Name)"
    } else {
        Write-Host "OK (no double-encoding): $($file.Name)"
    }
}

Write-Host ""
Write-Host "All HTML files processed."
