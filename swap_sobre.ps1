$file = "c:\Users\tonip\Desktop\LITTLE\sobre-nosotras.html"
$content = Get-Content $file -Raw -Encoding UTF8

$newMain = @"
    <main class="page-main">
        
        <!-- 1. El Manifiesto (Hero) -->
        <section class="manifesto-hero">
            <div class="container fade-in-up">
                <h1 class="manifesto-text" data-i18n="about_manifesto">"Creemos que la infancia no es una carrera, sino un lugar de asombro que merece ser respetado."</h1>
                <p class="manifesto-author" data-i18n="about_manifesto_author">El alma de Little Juego Libre</p>
            </div>
        </section>

        <!-- 2. Dos Martas, un mismo sueño (La Historia Original) -->
        <section class="section" id="sobre-nosotras" style="padding: 100px 0; background-color: var(--color-bg-primary);">
            <div class="container fade-in-up delay-1">
                <div class="about-story-layout" style="align-items: center;">
                    <!-- Column 1: Image -->
                    <div class="about-story-img">
                        <img src="./assets/fundadoras.jpg" alt="Marta M y Marta B - Little Juego Libre" style="border-radius: 0; box-shadow: 0 20px 40px rgba(0,0,0,0.06);">
                    </div>
                    <!-- Column 2: Text -->
                    <div class="about-story-text">
                        <h2 data-i18n="about_history_title" style="font-family: var(--font-heading); font-size: 2.2rem; margin-bottom: 20px; color: var(--color-text-main);">Dos Martas, un mismo sueño</h2>
                        <p data-i18n="about_history_p1" style="font-size: 1.05rem; line-height: 1.8; color: var(--color-text-light); margin-bottom: 20px;">Little juego libre nació en 2023 de la pasión por la educación y el juego. Desde nuestros inicios, hemos buscado crear un entorno en la naturaleza donde cada peque pueda expresarse y aprender a través del juego de manera creativa y libre.</p>
                        <p data-i18n="about_history_p2" style="font-size: 1.05rem; line-height: 1.8; color: var(--color-text-light);">Los momentos de calidad en familia para nosotras son clave, por eso a través de los años, hemos innovado en nuestras propuestas, asegurando que cada evento sea único y significativo para las familias.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3. Los Pilares de Little -->
        <section class="values-section">
            <div class="container">
                <div class="text-center fade-in-up">
                    <h2 style="font-family: var(--font-heading); font-size: 2.5rem; color: var(--color-text-main);">Nuestros Pilares</h2>
                    <p style="color: var(--color-text-light); margin-top: 10px; font-size: 1.1rem;">La filosofía que guía cada uno de nuestros montajes</p>
                </div>

                <div class="values-grid">
                    <div class="value-card fade-in-up delay-1">
                        <div class="value-icon">
                            <i class="fa-solid fa-hands-holding-child"></i>
                        </div>
                        <h3 class="value-title">Acompañamiento Natural</h3>
                        <p class="value-desc">No buscamos "entretener" ni sobreestimular. Diseñamos espacios donde los niños deciden su propio ritmo, explorando libremente en un entorno seguro y respetuoso con sus tiempos.</p>
                    </div>

                    <div class="value-card fade-in-up delay-2">
                        <div class="value-icon">
                            <i class="fa-solid fa-leaf"></i>
                        </div>
                        <h3 class="value-title">Materiales con Alma</h3>
                        <p class="value-desc">Huimos de los plásticos y las estridencias. Utilizamos madera, fibras naturales y elementos heurísticos que conectan con la naturaleza y despiertan el sentido estético de los pequeños.</p>
                    </div>

                    <div class="value-card fade-in-up delay-3">
                        <div class="value-icon">
                            <i class="fa-solid fa-champagne-glasses"></i>
                        </div>
                        <h3 class="value-title">Paz para Adultos</h3>
                        <p class="value-desc">Entendemos tus eventos. Mientras vuestros hijos se sumergen en un universo de calma y juego, vosotros podréis disfrutar de la celebración con total tranquilidad y elegancia.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- 4. Galería de Sensaciones (Backstage) -->
        <section class="sensory-gallery-section">
            <div class="container">
                <div class="text-center fade-in-up">
                    <h2 style="font-family: var(--font-heading); font-size: 2.5rem; color: var(--color-text-main);">Momentos Little</h2>
                    <p style="color: var(--color-text-light); margin-top: 10px; font-size: 1.1rem;">La belleza está en los pequeños detalles de cada juego</p>
                </div>

                <div class="gallery-grid">
                    <div class="gallery-item fade-in-up delay-1">
                        <img src="https://images.unsplash.com/photo-1596464716127-f2a82984de30?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Juegos de madera y piezas sueltas">
                    </div>
                    <div class="gallery-item fade-in-up delay-2">
                        <img src="https://images.unsplash.com/photo-1574880315424-6cc57bb6b668?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Juego sensorial en la naturaleza">
                    </div>
                    <div class="gallery-item fade-in-up delay-3">
                        <img src="https://images.unsplash.com/photo-1518774020141-94d0dc00a8ec?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Detalle de elementos Waldorf y Montessori">
                    </div>
                </div>
            </div>
        </section>

    </main>
"@

$content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?s)<main class="page-main">.*?</main>', $newMain)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Sobre-nosotras layout replaced!"
