
$filePath = "c:\Users\tonip\Desktop\LITTLE\js\translations.js"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# Repair triple/double encoding mess
$pairs = @{
    "ÃƒÂ¡" = "á";
    "ÃƒÂ©" = "é";
    "ÃƒÂ­" = "í";
    "ÃƒÂ³" = "ó";
    "ÃƒÂº" = "ú";
    "ÃƒÂ±" = "ñ";
    "ÃƒÂ¼" = "ü";
    "ÃƒÂ¡" = "á";
    "Ã‚Â·" = "·";
    "Ã‚Â¡" = "¡";
    "Ã‚Â¿" = "¿";
    "ÃƒÂ"  = "í"; # Special case for í ending sometimes
    "Ã¡"    = "á";
    "Ã©"    = "é";
    "Ã­"    = "í";
    "Ã³"    = "ó";
    "Ãº"    = "ú";
    "Ã±"    = "ñ";
    "Ã¼"    = "ü";
    "Ã‚"    = "";   # Residual artifacts
    "â€”"   = "—";
    "â€“"   = "–";
    "â€¦"   = "…";
    "â€˜"   = "‘";
    "â€™"   = "’";
    "â€œ"   = "“";
    "â€"   = "”"
}

foreach ($key in $pairs.Keys) {
    $content = $content.Replace($key, $pairs[$key])
}

# Write back as clean UTF-8 without BOM
[System.IO.File]::WriteAllText($filePath, $content, (New-Object System.Text.UTF8Encoding($false)))
Write-Host "Repaired encoding in $filePath"
