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

$headerTemplate = @"
    <header class="header" id="header">
        <div class="container nav-container">
            <a href="index.html" class="logo">
                <img src="./assets/logo.png" alt="Little Juego Libre" class="logo-img">
            </a>
            
            <nav class="nav-menu" id="nav-menu">
                <ul class="nav-list" style="position: relative;">
                    <li class="nav-item dropdown">
                        <a href="servicios.html" class="nav-link {SERVICIOS_ACTIVE}" data-i18n="nav_services">Servicios <span class="material-symbols-rounded" style="font-size: 16px; vertical-align: middle;">expand_more</span></a>
                        <ul class="dropdown-menu">
                            <li><a href="eventos.html" class="nav-link" data-i18n="nav_events">Eventos</a></li>
                            <li><a href="cumpleanos.html" class="nav-link" data-i18n="nav_birthdays">Cumpleaños</a></li>
                            <li><a href="juegos-libres.html" class="nav-link" data-i18n="nav_play">Juegos Libres</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a href="sobre-nosotras.html" class="nav-link {SOBRE_ACTIVE}" data-i18n="nav_about">Sobre Nosotras</a></li>
                    <li class="nav-item"><a href="colaboradores.html" class="nav-link {COLAB_ACTIVE}" data-i18n="nav_collab">Colaboradores</a></li>
                    <li class="nav-item"><a href="contacto.html" class="nav-link {CONTACTO_ACTIVE}" data-i18n="nav_contact">Contacto</a></li>
                </ul>
                <div class="nav-mobile-social">
                    <a href="https://www.instagram.com/little_juegolibre" target="_blank" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                    <a href="https://wa.me/34603919414" target="_blank" aria-label="WhatsApp"><i class="fa-brands fa-whatsapp"></i></a>
                </div>
            </nav>

            <div class="header-social desktop-only">
                <a href="https://www.instagram.com/little_juegolibre" target="_blank" aria-label="Instagram" class="nav-icon-delayed"><i
                        class="fa-brands fa-instagram" style="font-size: 24px;"></i></a>
                <a href="https://wa.me/34603919414" target="_blank" aria-label="WhatsApp" class="nav-icon-delayed"><i
                        class="fa-brands fa-whatsapp" style="font-size: 24px;"></i></a>
            </div>

            <div class="custom-language-selector" id="language-selector-container">
                <div class="language-selected" id="language-selected">
                    <span class="material-symbols-rounded" style="font-size: 18px; margin-right: 4px;">language</span>
                    <span class="lang-text" id="current-lang-text">ES</span>
                    <span class="material-symbols-rounded" style="font-size: 16px; margin-left: 2px;">expand_more</span>
                </div>
                <ul class="language-options" id="language-options">
                    <li data-value="es">ES</li>
                    <li data-value="en">EN</li>
                    <li data-value="de">DE</li>
                    <li data-value="fr">FR</li>
                    <li data-value="ca">CA</li>
                </ul>
            </div>

            <button class="nav-toggle" id="nav-toggle" aria-label="Abrir menú">
                <span class="material-symbols-rounded">menu</span>
            </button>
        </div>
    </header>
"@

$footerTemplate = @"
    <footer class="footer" style="padding-top: 100px;">
        <div class="container footer-container">
            <div class="footer-col text-center">
                <img src="./assets/logo-footer.png" alt="Little Juego Libre" class="footer-logo-img">
                <div class="social-links justify-center">
                    <a href="https://www.instagram.com/little_juegolibre" target="_blank" aria-label="Instagram"><i
                            class="fa-brands fa-instagram" style="font-size: 24px;"></i></a>
                    <a href="https://wa.me/34603919414" target="_blank" aria-label="WhatsApp"><i
                            class="fa-brands fa-whatsapp" style="font-size: 24px;"></i></a>
                </div>
            </div>

            <div class="footer-nav">
                <ul class="footer-links">
                    <li><a href="index.html" data-i18n="nav_home">Inicio</a></li>
                    <li><a href="servicios.html" data-i18n="nav_services">Servicios</a></li>
                    <li><a href="sobre-nosotras.html" data-i18n="nav_about">Sobre Nosotras</a></li>
                    <li><a href="colaboradores.html" data-i18n="nav_collab">Colaboradores</a></li>
                    <li><a href="contacto.html" data-i18n="nav_contact">Contacto</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p><span data-i18n="footer_rights">Derechos de Autor &copy; </span><span id="year"></span><span
                    data-i18n="footer_designed"> Little Juego Libre | Diseñado con alma</span></p>
        </div>
    </footer>
"@

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        # Determine active classes
        $serviciosActive = ""
        $sobreActive = ""
        $colabActive = ""
        $contactoActive = ""
        
        if ($file -match "servicios.html|eventos.html|cumpleanos.html|juegos-libres.html") { $serviciosActive = "active" }
        elseif ($file -eq "sobre-nosotras.html") { $sobreActive = "active" }
        elseif ($file -eq "colaboradores.html") { $colabActive = "active" }
        elseif ($file -eq "contacto.html") { $contactoActive = "active" }
        
        $currentHeader = $headerTemplate
        $currentHeader = $currentHeader.Replace("{SERVICIOS_ACTIVE}", $serviciosActive)
        $currentHeader = $currentHeader.Replace("{SOBRE_ACTIVE}", $sobreActive)
        $currentHeader = $currentHeader.Replace("{COLAB_ACTIVE}", $colabActive)
        $currentHeader = $currentHeader.Replace("{CONTACTO_ACTIVE}", $contactoActive)
        
        $content = [regex]::Replace($content, "(?s)<header class=`"header`".*?</header>", $currentHeader.Trim())
        $content = [regex]::Replace($content, "(?s)<footer class=`"footer`".*?</footer>", $footerTemplate.Trim())
        
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Synced nav/footer for $file"
    } else {
        Write-Host "File not found: $file"
    }
}
