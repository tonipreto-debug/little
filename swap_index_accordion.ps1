$file = "c:\Users\tonip\Desktop\LITTLE\index.html"
$content = Get-Content $file -Raw -Encoding UTF8

$newServices = @"
        <!-- Home Services (Immersive Accordion) -->
        <section class="section home-services bg-white" style="padding-top: 50px; padding-bottom: 80px;">
            <div class="container text-center fade-in-up">
                <h2 class="section-title" style="color: var(--color-accent-primary); margin-bottom: 50px;"
                    data-i18n="home_services_title">Nuestros Servicios</h2>
            </div>

            <div class="services-hero fade-in-up" style="padding-top: 0; min-height: 500px; height: 60vh;">
                <div class="hero-panel pop-in delay-1" style="background-image: url('https://images.unsplash.com/photo-1596464716127-f2a82984de30?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');" onclick="window.location.href='juegos-libres.html'">
                    <div class="panel-content">
                        <h2 class="panel-title" data-i18n="srv_1_title">Juego Libre</h2>
                        <p class="panel-desc" data-i18n="srv_1_desc">Espacios preparados con mimo para la experimentación sensorial, donde los peques aprenden jugando a su ritmo.</p>
                    </div>
                </div>
                <div class="hero-panel pop-in delay-2" style="background-image: url('https://images.unsplash.com/photo-1530103862676-de8892bc95ce?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');" onclick="window.location.href='cumpleanos.html'">
                    <div class="panel-content">
                        <h2 class="panel-title" data-i18n="srv_2_title">Cumpleaños</h2>
                        <p class="panel-desc" data-i18n="srv_2_desc">Celebra un cumpleaños diferente con rincones temáticos pensados 100% en la diversión de tu peque y sus amigos.</p>
                    </div>
                </div>
                <div class="hero-panel pop-in delay-3" style="background-image: url('https://images.unsplash.com/photo-1510798831971-661eb04b3739?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');" onclick="window.location.href='eventos.html'">
                    <div class="panel-content">
                        <h2 class="panel-title" data-i18n="srv_3_title">Little a Domicilio</h2>
                        <p class="panel-desc" data-i18n="srv_3_desc">Llevamos la magia, los tipis y toda nuestra propuesta de juego donde necesites: tu casa, un parque o un local de eventos.</p>
                    </div>
                </div>
            </div>
            
            <div class="container text-center fade-in-up" style="margin-top: 50px;">
                <a href="servicios.html" class="btn btn-primary" style="background: transparent; color: var(--color-accent-primary); border: 2px solid var(--color-accent-primary); padding: 12px 35px; border-radius: 50px;">Ver todos los detalles</a>
            </div>
        </section>
"@

$content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?s)<!-- Home Services \(Jaulas\) -->.*?</section>', $newServices)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Home Services replaced!"
