$htmlFiles = Get-ChildItem -Path "." -Filter "*.html"
$enc1252 = [System.Text.Encoding]::GetEncoding(1252)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$replacements = @{
    "Ã¡" = "a"
    "Ã©" = "e"
    "Ã³" = "o"
    "Ãº" = "u"
    "Ã­" = "i"
    "Ã±" = "n"
    "Ã¨" = "e"
    "Ã " = "a"
    "Âº" = "o"
    "Âª" = "a"
    "Â¡" = "!"
    "Â¿" = "?"
    "Â·" = "-"
    "Â«" = "<"
    "Â»" = ">"
    "Â©" = "(C)"
    "Â°" = " grados"
    "Ã±o" = "anyo"
}

foreach ($file in $htmlFiles) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $text = $enc1252.GetString($bytes)
    
    $hasIssues = $false
    foreach ($key in $replacements.Keys) {
        if ($text.Contains($key)) {
            $hasIssues = $true
            break
        }
    }
    
    if ($hasIssues) {
        # Better approach: re-encode properly
        # The bytes are actually UTF-8 bytes, but we read them as Latin-1
        # We need to take the original bytes and decode as UTF-8
        $utf8text = [System.Text.Encoding]::UTF8.GetString($bytes)
        [System.IO.File]::WriteAllText($file.FullName, $utf8text, $utf8NoBom)
        Write-Host "Fixed (re-encoded as UTF-8): $($file.Name)"
    } else {
        Write-Host "OK: $($file.Name)"
    }
}

Write-Host ""
Write-Host "All done."
