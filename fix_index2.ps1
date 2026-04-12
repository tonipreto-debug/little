$file = "c:\Users\tonip\Desktop\LITTLE\index.html"
$content = Get-Content $file -Raw -Encoding UTF8

$search = @"
                <div class=`"about-grid`" style=`"gap: 30px; display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); text-align: left;`">
        </section>
"@

$replace = @"
                <div class="about-grid" style="gap: 30px; display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); text-align: left;">
                    <div class="glass-card fade-in-up">
                        <div class="glass-card-icon">
                            <i class="fa-solid fa-face-smile"></i>
                        </div>
                        <h3 data-i18n="home_essence_1_title">Juego Libre</h3>
                        <p data-i18n="home_essence_1_desc">Creamos un espacio donde los más pequeños son los protagonistas. Donde explorar, jugar y mancharse forma parte de aprender y disfrutar.</p>
                    </div>

                    <div class="glass-card fade-in-up delay-1">
                        <div class="glass-card-icon">
                            <i class="fa-solid fa-wand-magic-sparkles"></i>
                        </div>
                        <h3 data-i18n="home_essence_2_title">Eventos personalizados</h3>
                        <p data-i18n="home_essence_2_desc">Diseñamos eventos personalizados, con la temática, los colores y los detalles que hacen feliz a tu peque.<br>Nos gusta escucharos, crear juntos y transformar cada idea en una experiencia especial.</p>
                    </div>

                    <div class="glass-card fade-in-up delay-2">
                        <div class="glass-card-icon">
                            <i class="fa-solid fa-leaf"></i>
                        </div>
                        <h3 data-i18n="home_essence_3_title">Ambiente</h3>
                        <p data-i18n="home_essence_3_desc">Nos importa que los peques se sientan cómodos. Usamos materiales naturales y creamos entornos que invitan a descubrir y desarrollar su imaginación a su ritmo.</p>
                    </div>
                </div>
            </div>
        </section>
"@

$content = $content.Replace($search, $replace)

# Also adding fade-in-up to testimonial cards that don't have it
$content = $content.Replace("<div class=`"testimonial-card`">", "<div class=`"testimonial-card fade-in-up`">")
$content = $content.Replace("<div class=`"testimonial-card delay-1`">", "<div class=`"testimonial-card fade-in-up delay-1`">")
$content = $content.Replace("<div class=`"testimonial-card delay-2`">", "<div class=`"testimonial-card fade-in-up delay-2`">")

# And adding a subtle scale-up to the form and modal for later
$content = $content.Replace("<div class=`"review-modal-content`">", "<div class=`"review-modal-content scale-up`">")

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Fixed!"
