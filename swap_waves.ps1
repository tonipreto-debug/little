$file1 = "c:\Users\tonip\Desktop\LITTLE\index.html"
$content1 = Get-Content $file1 -Raw -Encoding UTF8

# 1. Hero Quote
$content1 = $content1 -replace '<h1 class="hero-quote" data-i18n="hero_quote">', '<h1 class="hero-quote animate-wave wave-style-1" data-i18n="hero_quote">'
# 2. Detrás de la magia
$content1 = $content1 -replace '<h2 data-i18n="intro_title">', '<h2 class="animate-wave wave-style-2" data-i18n="intro_title">'
# 3. Nuestros Servicios
$content1 = $content1 -replace '<h2 class="section-title" style="color: var\(--color-accent-primary\); margin-bottom: 50px;"\s*data-i18n="home_services_title">', '<h2 class="section-title animate-wave wave-style-3" style="color: var(--color-accent-primary); margin-bottom: 50px;" data-i18n="home_services_title">'
# 4. Testimonios
$content1 = $content1 -replace '<h2 class="section-title" style="color: white; margin-bottom: 50px;" data-i18n="testi_title">', '<h2 class="section-title animate-wave wave-style-1" style="color: white; margin-bottom: 50px;" data-i18n="testi_title">'
# 5. FAQ
$content1 = $content1 -replace '<h2 style="color: var\(--color-accent-primary\); text-align: center; margin-bottom: 40px; font-size: 2\.2rem;"\s*data-i18n="faq_title">', '<h2 class="animate-wave wave-style-2" style="color: var(--color-accent-primary); text-align: center; margin-bottom: 40px; font-size: 2.2rem;" data-i18n="faq_title">'

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file1, $content1, $utf8NoBom)


$file2 = "c:\Users\tonip\Desktop\LITTLE\servicios.html"
$content2 = Get-Content $file2 -Raw -Encoding UTF8

# FAQ in servicios
$content2 = $content2 -replace '<h2 style="color: var\(--color-accent-primary\); text-align: center; margin-bottom: 40px; font-size: 2\.2rem;"\s*data-i18n="faq_title">', '<h2 class="animate-wave wave-style-2" style="color: var(--color-accent-primary); text-align: center; margin-bottom: 40px; font-size: 2.2rem;" data-i18n="faq_title">'
# Anatomy
$content2 = $content2 -replace '<h2 style="font-family: var\(--font-heading\); font-size: 2\.5rem; color: var\(--color-accent-primary\);">La Anatomía de nuestra Magia</h2>', '<h2 class="animate-wave wave-style-3" style="font-family: var(--font-heading); font-size: 2.5rem; color: var(--color-accent-primary);">La Anatomía de nuestra Magia</h2>'
# Timeline
$content2 = $content2 -replace '<h2 style="font-family: var\(--font-heading\); font-size: 2\.5rem; color: var\(--color-accent-primary\);">El Recorrido del Servicio</h2>', '<h2 class="animate-wave wave-style-1" style="font-family: var(--font-heading); font-size: 2.5rem; color: var(--color-accent-primary);">El Recorrido del Servicio</h2>'
# Universes
$content2 = $content2 -replace '<h2 style="font-family: var\(--font-heading\); font-size: 2\.5rem; color: var\(--color-accent-primary\);">Nuestros Universos</h2>', '<h2 class="animate-wave wave-style-2" style="font-family: var(--font-heading); font-size: 2.5rem; color: var(--color-accent-primary);">Nuestros Universos</h2>'
# Dynamic Link
$content2 = $content2 -replace '<h2 style="font-family: var\(--font-heading\); font-size: 2\.5rem; margin-bottom: 15px;">¿Listo para preparar algo mágico\?</h2>', '<h2 class="animate-wave wave-style-3" style="font-family: var(--font-heading); font-size: 2.5rem; margin-bottom: 15px;">¿Listo para preparar algo mágico?</h2>'

[System.IO.File]::WriteAllText($file2, $content2, $utf8NoBom)

Write-Host "Classes injected!"
