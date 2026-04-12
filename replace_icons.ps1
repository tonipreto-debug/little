$files = "colaboradores.html", "sobre-nosotras.html", "servicios.html", "contacto.html", "eventos.html", "cumpleanos.html", "juegos-libres.html"

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

        # 1. Add FA link before style.css
        if (-not $content.Contains("font-awesome")) {
            $content = $content.Replace('<link rel="stylesheet" href="./css/style.css', '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />' + [Environment]::NewLine + '    <link rel="stylesheet" href="./css/style.css')
        }

        # 2. Replace language selector text
        $content = $content.Replace('id="current-lang-text">Español</span>', 'id="current-lang-text">ES</span>')
        $content = $content.Replace('<li data-value="es">Español</li>', '<li data-value="es">ES</li>')
        $content = $content.replace('<li data-value="en">English</li>', '<li data-value="en">EN</li>')
        $content = $content.replace('<li data-value="de">Deutsch</li>', '<li data-value="de">DE</li>')
        $content = $content.replace('<li data-value="fr">Français</li>', '<li data-value="fr">FR</li>')
        $content = $content.replace('<li data-value="ca">Català</li>', '<li data-value="ca">CA</li>')

        # 3. Handle Instagram Material Icon
        $mcLine = '<span' + [Environment]::NewLine + '                            class="material-symbols-rounded">photo_camera</span>'
        $faLine = '<i class="fa-brands fa-instagram" style="font-size: 24px;"></i>'
        $content = $content.Replace($mcLine, $faLine)
        
        $mcLine2 = '<span class="material-symbols-rounded">photo_camera</span>'
        $content = $content.Replace($mcLine2, $faLine)

        # 4. Handle WhatsApp Material Icon
        $mwLine = '<span' + [Environment]::NewLine + '                            class="material-symbols-rounded">chat</span>'
        $fwLine = '<i class="fa-brands fa-whatsapp" style="font-size: 24px;"></i>'
        $content = $content.Replace($mwLine, $fwLine)

        $mwLine2 = '<span class="material-symbols-rounded">chat</span>'
        $content = $content.Replace($mwLine2, $fwLine)

        # Contacto specific handling
        $content = $content.Replace(
            '<span class="material-symbols-rounded" style="margin-right: 8px;">photo_camera</span>',
            '<i class="fa-brands fa-instagram" style="font-size: 20px; margin-right: 8px;"></i>'
        )
        $content = $content.Replace(
            '<span class="material-symbols-rounded" style="margin-right: 8px;">chat</span>',
            '<i class="fa-brands fa-whatsapp" style="font-size: 20px; margin-right: 8px;"></i>'
        )

        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $file"
    } else {
        Write-Host "File not found: $file"
    }
}
