$source = "c:\Users\tonip\Desktop\LITTLE\cumpleanos.html"
$content = Get-Content $source -Raw -Encoding UTF8

$headerEnd = $content.IndexOf("<!-- PANTALLA DE ELECCIÓN: GLOBOS -->")
$headerHTML = $content.Substring(0, $headerEnd).Trim()

$footerStart = $content.IndexOf("<!-- Footer -->")
$footerHTML = $content.Substring($footerStart)
# Need to remove the mobile timeline JS script as it's logic specific to old timeline.
$footerHTML = $footerHTML -replace '(?s)<!-- Mobile Timeline WOW Animation Script -->.*?</script>', ''


$heroLittle = $content -match '(?s)<!-- Cumpleaños Hero \(Confetti & Background\) -->.*?</section>'
$heroLittleContent = $matches[0]

$heroDomi = $content -match '(?s)<section class="home-bd-hero text-center".*?</section>'
$heroDomiContent = $matches[0]

$littleContent = @"
$headerHTML
        $heroLittleContent

        <!-- SECTION: SPLIT LAYOUT -->
        <section class="bd-split-section">
            <div class="container fade-in-up">
                <!-- ROW 1 -->
                <div class="bd-split-row">
                    <div class="bd-split-text">
                        <div class="bd-split-icon"><span class="material-symbols-rounded" style="font-size:2.5rem;">sunny</span></div>
                        <h3 class="bd-split-title" data-i18n="bd1_t1_title">Edades Mágicas</h3>
                        <p class="bd-split-desc" data-i18n="bd1_t1_desc">Celebramos cumpleaños desde la primera vuelta al sol hasta los 5 años.</p>
                    </div>
                    <div class="bd-split-media">
                        <img loading="lazy" decoding="async" src="./assets/cumple_nueva_1.jpg" alt="Actividades Sensoriales Little" class="bd-split-img">
                    </div>
                </div>

                <!-- ROW 2 -->
                <div class="bd-split-row reverse">
                    <div class="bd-split-text">
                        <div class="bd-split-icon"><span class="material-symbols-rounded" style="font-size:2.5rem;">palette</span></div>
                        <h3 class="bd-split-title" data-i18n="bd1_t2_title">100% Personalizado</h3>
                        <p class="bd-split-desc" data-i18n="bd1_t2_desc">Cada cumpleaños es tematizado y único, decorado milimétricamente con los colores favoritos del/la peque.</p>
                    </div>
                    <div class="bd-split-media">
                        <img loading="lazy" decoding="async" src="./assets/cumple_nueva_2.jpg" alt="Decoración Personalizada Little" class="bd-split-img">
                    </div>
                </div>

                <!-- ROW 3 -->
                <div class="bd-split-row">
                    <div class="bd-split-text">
                        <div class="bd-split-icon"><span class="material-symbols-rounded" style="font-size:2.5rem;">star</span></div>
                        <h3 class="bd-split-title" data-i18n="bd1_t3_title">¿Qué incluye nuestra propuesta?</h3>
                        <ul class="bd-feat-list">
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary);">science</span><span data-i18n="bd1_t3_i1">Propuestas avanzadas de experimentación sensorial.</span></li>
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary);">water_drop</span><span data-i18n="bd1_t3_i2">Bandejas con agua y elementos congelados para hacer trasvases y descubrimientos.</span></li>
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary);">brush</span><span data-i18n="bd1_t3_i3">Actividades de arte expresivas y creativas.</span></li>
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary);">toys</span><span data-i18n="bd1_t3_i4">Parte de juego simbólico integral con casita a doble altura, cocina de madera de 3 metros y rincones mágicos.</span></li>
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary);">favorite</span><span data-i18n="bd1_t3_i5">Y mucho más, todo pensado y realizado con mimo, alma y detalle.</span></li>
                        </ul>
                    </div>
                    <div class="bd-split-media" style="aspect-ratio:3/4;">
                        <video autoplay muted loop playsinline src="./assets/hero-video-1.mp4"></video>
                    </div>
                </div>

                <!-- CTA -->
                <div class="bd-split-row reverse" style="align-items:center;">
                    <div class="bd-split-text" style="background:#fff; padding: 40px; border-radius: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 2px solid var(--color-accent-primary); border-bottom-width: 6px;">
                        <div class="bd-split-icon" style="background:var(--color-accent-primary); color:white;"><span class="material-symbols-rounded" style="font-size:2.5rem;">chat_bubble_outline</span></div>
                        <h3 class="bd-split-title" data-i18n="bd1_t4_title">¡Nos encantará organizarlo!</h3>
                        <p class="bd-split-desc" data-i18n="bd1_t4_desc">Para más información o para reservar tu fecha directa, podéis escribirnos por WhatsApp o mandarnos un mensaje directo sin compromiso.</p>
                        <a href="https://wa.me/34603919414" target="_blank" class="btn btn-primary" style="display: inline-flex; align-items: center; gap: 8px;">
                            <i class="fa-brands fa-whatsapp" style="font-size: 1.2rem;"></i> <span data-i18n="bd1_whatsapp">Escríbenos por WhatsApp</span>
                        </a>
                    </div>
                    <div class="bd-split-media">
                        <img loading="lazy" decoding="async" src="./assets/cumple-little-3.jpg" alt="Organización Little" class="bd-split-img">
                    </div>
                </div>

            </div>
        </section>
    </main>

$footerHTML
"@

$domiContent = @"
$headerHTML
        $heroDomiContent

        <!-- SECTION: SPLIT LAYOUT -->
        <section class="bd-split-section">
            <div class="container fade-in-up">
                <!-- ROW 1 -->
                <div class="bd-split-row">
                    <div class="bd-split-text">
                        <div class="bd-split-icon"><span class="material-symbols-rounded" style="font-size:2.5rem;">sunny</span></div>
                        <h3 class="bd-split-title" data-i18n="bd1_t1_title">Edades Mágicas</h3>
                        <p class="bd-split-desc" data-i18n="bd2_c1_desc">Celebramos cumples desde la primera vuelta al sol hasta los 5 años.</p>
                    </div>
                    <div class="bd-split-media">
                        <img loading="lazy" decoding="async" src="./assets/cumple-domi-1.jpg" alt="Cumpleaños a Domicilio Little" class="bd-split-img">
                    </div>
                </div>

                <!-- ROW 2 -->
                <div class="bd-split-row reverse">
                    <div class="bd-split-text">
                        <div class="bd-split-icon"><span class="material-symbols-rounded" style="font-size:2.5rem;">palette</span></div>
                        <h3 class="bd-split-title" data-i18n="bd2_c2">Tematización</h3>
                        <p class="bd-split-desc" data-i18n="bd2_c2_desc">Cada cumpleaños es personalizado con los colores favoritos del/la peque.</p>
                    </div>
                    <div class="bd-split-media">
                        <img loading="lazy" decoding="async" src="./assets/cumple-domi-2.jpg" alt="Tematización Domicilio" class="bd-split-img">
                    </div>
                </div>

                <!-- ROW 3 -->
                <div class="bd-split-row">
                    <div class="bd-split-text">
                        <div class="bd-split-icon"><span class="material-symbols-rounded" style="font-size:2.5rem;">star</span></div>
                        <h3 class="bd-split-title" data-i18n="bd2_feat_title">¿Qué Incluye?</h3>
                        <ul class="bd-feat-list">
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary); font-size:2rem;">science</span><span data-i18n="bd2_feat_1" style="margin-top:6px;">Propuestas avanzadas de <strong>experimentación sensorial</strong>.</span></li>
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary); font-size:2rem;">water_drop</span><span data-i18n="bd2_feat_2" style="margin-top:6px;"><strong>Bandejas con agua</strong> preparadas para experimentar y hacer trasvases.</span></li>
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary); font-size:2rem;">brush</span><span data-i18n="bd2_feat_3" style="margin-top:6px;">También ofrecemos divertidas e inmersivas <strong>actividades de arte</strong>.</span></li>
                            <li><span class="material-symbols-rounded" style="color:var(--color-accent-primary); font-size:2rem;">favorite</span><span data-i18n="bd2_feat_4" style="margin-top:6px;">Y mucho más, todo pensado y realizado con <strong>mimo, alma y detalle</strong>.</span></li>
                        </ul>
                    </div>
                    <div class="bd-split-media">
                        <img loading="lazy" decoding="async" src="./assets/cumple-domi-3.jpg" alt="Actividades Domicilio" class="bd-split-img">
                    </div>
                </div>

                <!-- CTA -->
                <div class="bd-split-row reverse" style="align-items:center;">
                    <div class="bd-split-text" style="background:#fff; padding: 40px; border-radius: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 2px solid var(--color-accent-primary); border-bottom-width: 6px;">
                        <p class="bd-split-desc" data-i18n="bd2_cta_desc" style="margin-top:10px;">
                            <span class="material-symbols-rounded" style="font-weight: 300; font-size: 1.2rem; vertical-align: middle; margin-right: 5px;">description</span> Os enviamos un <strong>presupuesto completo</strong> con todo lo que incluye para que sepáis cómo será ese día tan especial.<br><br>
                            <span class="material-symbols-rounded" style="font-weight: 300; font-size: 1.2rem; vertical-align: middle; margin-right: 5px;">chat_bubble_outline</span> Para más info o reservar fecha, podéis escribirnos por WhatsApp o mensaje directo. ¡Nos encantará organizarlo con vosotros! <span class="material-symbols-rounded" style="font-weight: 300; font-size: 1.2rem; vertical-align: middle; margin-left: 5px;">flare</span>
                        </p>
                        <a href="https://wa.me/34603919414" target="_blank" class="btn btn-primary" style="font-size: 1.1rem; padding: 15px 35px; width:100%;">
                            <i class="fa-brands fa-whatsapp" style="margin-right: 8px; font-size: 1.3rem;"></i> <span data-i18n="bd1_whatsapp">Escríbenos por WhatsApp</span>
                        </a>
                    </div>
                    <div class="bd-split-media" style="background-image:url('./assets/home-bg-1.jpg'); background-size:cover;">
                        <img src="./assets/logo.png" style="opacity:0.1; width:100%; height:100%; object-fit:contain; padding:50px;">
                    </div>
                </div>

            </div>
        </section>
    </main>

$footerHTML
"@

Set-Content -Path "c:\Users\tonip\Desktop\LITTLE\cumpleanos-little.html" -Value $littleContent -Encoding UTF8
Set-Content -Path "c:\Users\tonip\Desktop\LITTLE\cumpleanos-domicilio.html" -Value $domiContent -Encoding UTF8
Write-Host "Both new HTML files generated successfully."
