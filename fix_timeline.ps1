$filePath = "c:\Users\tonip\Desktop\LITTLE\juego-libre-interior.html"
$content = Get-Content $filePath -Raw -Encoding UTF8

$cssSnippet = @"
        /* Animated floating flowers (Section specific) */
        .flower {
            position: absolute;
            font-size: 2.2rem;
            opacity: 0;
            animation: flower-fall linear infinite;
            pointer-events: none;
            z-index: 0;
            filter: grayscale(100%);
        }
        @keyframes flower-fall {
            0%   { top: -30px; transform: rotate(0deg) scale(0); opacity: 0; }
            10%  { top: 5%; opacity: 0.35; transform: rotate(20deg) scale(1); }
            80%  { top: 80%; opacity: 0.25; transform: rotate(200deg) scale(1); }
            100% { top: 100%; transform: rotate(360deg) scale(0.8); opacity: 0; }
        }
"@

if ($content -notmatch "flower-fall") {
    $content = $content -replace "\/\* ---- REVEAL COUNTER STRIP ---- \*\/", "$cssSnippet`n        /* ---- REVEAL COUNTER STRIP ---- */"
}

$newRows = @"
<!-- ROW 1 (1 HORA) -->
                <div class="curvy-row fade-in-up">
                    <svg class="curvy-svg" viewBox="0 0 100 100" preserveAspectRatio="none">
                        <path d="M 50 0 C 90 20, 90 80, 50 100" stroke="url(#gradInt)" fill="none" vector-effect="non-scaling-stroke"/>
                    </svg>
                    <div class="curvy-icon" style="left:90%; z-index:2;">
                        <span class="material-symbols-rounded" style="font-variation-settings:'wght' 300;font-size:2.2rem;">schedule</span>
                    </div>
                    <div class="curvy-content" style="left:0;width:40%;text-align:right; z-index:2;">
                        <h3 style="color:var(--int-dark);" data-i18n="int_time_title">1 Hora</h3>
                        <p data-i18n="int_time_desc">Sesiones de 1h donde cada peque va a su ritmo acompañado de un adulto.</p>
                    </div>
                </div>

                <!-- ROW 2 (ZONAS TEMÁTICAS) -->
                <div class="curvy-row fade-in-up delay-1">
                    <svg class="curvy-svg" viewBox="0 0 100 100" preserveAspectRatio="none">
                        <path d="M 50 0 C 10 20, 10 80, 50 100" stroke="url(#gradInt)" fill="none" vector-effect="non-scaling-stroke"/>
                    </svg>
                    <div class="curvy-icon" style="left:10%; z-index:2;">
                        <span class="material-symbols-rounded" style="font-variation-settings:'wght' 300;font-size:2.2rem;">cottage</span>
                    </div>
                    <div class="curvy-content" style="left:60%;width:40%;text-align:left; z-index:2;">
                        <h3 style="color:var(--int-dark);" data-i18n="int_zones_title">Zonas Temáticas</h3>
                        <p data-i18n="int_zones_desc">(en una sala experimentación con bases secas y en otra sala experimentación con bases cochinas para un mejor desarollo de todos los sentidos de los peques)</p>
                    </div>
                </div>

                <!-- ROW 3 (SILENCIO/MÚSICA) -->
                <div class="curvy-row fade-in-up delay-2">
                    <svg class="curvy-svg" viewBox="0 0 100 100" preserveAspectRatio="none">
                        <path d="M 50 0 C 90 20, 90 80, 50 100" stroke="url(#gradInt)" fill="none" vector-effect="non-scaling-stroke"/>
                    </svg>
                    <div class="curvy-icon" style="left:90%; z-index:2;">
                        <span class="material-symbols-rounded" style="font-variation-settings:'wght' 300;font-size:2.2rem;">volume_off</span>
                    </div>
                    <div class="curvy-content" style="left:0;width:40%;text-align:right; z-index:2;">
                        <p data-i18n="int_silence_desc" style="font-size: 1.1rem; margin-top: 10px;">Música suave de fondo, sin ruido ajeno, sin pantallas. Un entorno que favorece la concentración, el asombro y la conexión entre adultos y peques.</p>
                    </div>
                </div>

                <!-- ROW 4 (MATERIALES) -->
                <div class="curvy-row fade-in-up delay-3" style="min-height:280px;">
                    <svg class="curvy-svg" viewBox="0 0 100 100" preserveAspectRatio="none">
                        <path d="M 50 0 C 10 20, 10 80, 50 100" stroke="url(#gradInt)" fill="none" vector-effect="non-scaling-stroke"/>
                    </svg>
                    <div class="curvy-icon" style="left:10%; z-index:2;">
                        <span class="material-symbols-rounded" style="font-variation-settings:'wght' 300;font-size:2.2rem;">eco</span>
                    </div>
                    <div class="curvy-content" style="left:60%;width:40%;text-align:left; z-index:2;">
                        <h3 style="color:var(--int-dark);" data-i18n="int_mat_title">Materiales</h3>
                        <p style="margin-bottom:20px;" data-i18n="int_mat_desc">bases 100% comestibles, caseras y seguras.</p>
                        <a href="contacto.html" class="btn-int-primary" style="display:inline-block;text-decoration:none;" data-i18n="int_btn_book">Reservar sesión interior</a>
                    </div>
                </div>

                <!-- ROW 5 (ALERGIAS) -->
                <div class="curvy-row fade-in-up delay-4" style="min-height:220px;">
                    <svg class="curvy-svg" viewBox="0 0 100 100" preserveAspectRatio="none">
                        <path d="M 50 0 C 90 20, 90 80, 50 100" stroke="url(#gradInt)" fill="none" vector-effect="non-scaling-stroke"/>
                    </svg>
                    <div class="curvy-icon" style="left:90%; z-index:2;">
                        <span class="material-symbols-rounded" style="font-variation-settings:'wght' 300;font-size:2.2rem;">medical_information</span>
                    </div>
                    <div class="curvy-content" style="left:0;width:40%;text-align:right; z-index:2;">
                        <h3 style="color:var(--int-dark);" data-i18n="int_alerg_title">Alergias</h3>
                        <p data-i18n="int_alerg_desc" style="font-size: 1.05rem;">si tu peque tiene alguna alergia hacerlo llegar a la hora de reservar! nos adaptamos a ella sin problema!</p>
                    </div>
                </div>

                <div style="text-align:center;margin-top:-20px;position:relative;z-index:2;">
                    <span class="material-symbols-rounded" style="font-size:2.5rem;color:var(--int-accent);font-variation-settings:'wght' 200;">home</span>
                </div>
            </div>
        </section>
"@

$content = $content -replace '(?s)<!-- ROW 1 -->.*?</section>', $newRows

$flowersHtml = @"
    <!-- Floating Flowers Background Effect -->
    <span class="flower" style="left:12%; animation-duration:14s; animation-delay:0s;">🌼</span>
    <span class="flower" style="left:80%; animation-duration:18s; animation-delay:3s;">🌼</span>
    <span class="flower" style="left:25%; animation-duration:15s; animation-delay:8s;">🌼</span>
    <span class="flower" style="left:65%; animation-duration:12s; animation-delay:5s;">🌼</span>
    <span class="flower" style="left:40%; animation-duration:16s; animation-delay:1.5s;">🌼</span>
    <span class="flower" style="left:88%; animation-duration:20s; animation-delay:10s;">🌼</span>
"@

if ($content -notmatch "<!-- Floating Flowers Background Effect -->") {
    $content = $content -replace 'id="que-ofrecemos">', 'id="que-ofrecemos" style="overflow:hidden; position:relative;">`n' + $flowersHtml
}

Set-Content -Path $filePath -Value $content -Encoding UTF8
Write-Host "Replaced timeline items and injected flowers via PS1 securely!"
