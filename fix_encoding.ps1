$files = @(
    "index.html",
    "contacto.html",
    "servicios.html",
    "sobre-nosotras.html",
    "colaboradores.html",
    "eventos.html",
    "cumpleanos.html",
    "juegos-libres.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        # Long-term fix for the encoding hiccup observed
        $content = $content.Replace("CumpleaÃ±os", "Cumpleaños")
        $content = $content.Replace("MenÃº", "Menú")
        $content = $content.Replace("Abrir menÃº", "Abrir menú")
        
        # Ensure UTF8 without BOM (standard for web)
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
        
        Write-Host "Fixed encoding for $file"
    }
}
