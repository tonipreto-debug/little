Get-ChildItem -Path "." -Filter "*.html" | ForEach-Object {
    $f = $_.FullName
    $bytes = [System.IO.File]::ReadAllBytes($f)
    $t = [System.Text.Encoding]::UTF8.GetString($bytes)
    $newT = $t.Replace('./assets/logo-coral.jpg" alt="Little Juego Libre" class="footer-logo-img"', './assets/logo.png" alt="Little Juego Libre" class="footer-logo-img"')
    if ($newT -ne $t) {
        $utf8 = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($f, $newT, $utf8)
        Write-Host "Updated: $($_.Name)"
    }
}
Write-Host "Done."
