$filePath = "c:\Users\tonip\Desktop\LITTLE\juego-libre-interior.html"
$content = Get-Content $filePath -Raw -Encoding UTF8

$newContent = @"
<!-- ===== CTA ===== -->
        <section class="int-cta">
            <div class="container fade-in-up">
                <h2 data-i18n="ext_cta_title">¿Preparados para jugar?</h2>
                <p data-i18n="ext_cta_desc">Escríbenos y os contamos las próximas fechas disponibles. ¡Las plazas vuelan!</p>
                <div style="display: flex; gap: 16px; justify-content: center; flex-wrap: wrap;">
                    <a href="https://wa.me/34603919414" target="_blank" class="btn-int-primary cta-btn" style="box-shadow: none;">
                        <i class="fa-brands fa-whatsapp"></i> <span data-i18n="ext_cta_wa">Hablar por WhatsApp</span>
                    </a>
                    <a href="contacto.html" class="btn-int-outline-light cta-btn">
                        <span class="material-symbols-rounded" style="font-size:1.1rem;">mail</span> <span data-i18n="ext_cta_contact">Formulario de contacto</span>
                    </a>
                </div>
            </div>
        </section>
"@

# Regex replace spanning multiple lines
$newText = $content -replace '(?s)<!-- ===== LIGHT ANIMATION SECTION ===== -->.*?</section>', $newContent

Set-Content -Path $filePath -Value $newText -Encoding UTF8
Write-Host "Regex replace executed."
