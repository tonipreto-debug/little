$file = "c:\Users\tonip\Desktop\LITTLE\servicios.html"
$content = Get-Content $file -Raw -Encoding UTF8

$newMain = @"
    <main class="page-main">
        
        <!-- 1. Hero Accordion Slider -->
        <section class="services-hero fade-in-up">
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
        </section>

        <!-- 2. La Anatomía de un Rincón Little -->
        <section class="anatomy-section">
            <div class="container fade-in-up">
                <div class="text-center">
                    <h2 style="font-family: var(--font-heading); font-size: 2.5rem; color: var(--color-accent-primary);">La Anatomía de nuestra Magia</h2>
                    <p style="color: var(--color-text-light); margin-top: 10px; font-size: 1.1rem;">No somos simple "animación infantil". Somos creadores de universos.</p>
                </div>
                
                <div class="anatomy-grid">
                    <div class="anatomy-image fade-in-up delay-1">
                        <!-- Temporarily using an unsplash image for the "anatomy" illustration -->
                        <img src="https://images.unsplash.com/photo-1518774020141-94d0dc00a8ec?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Detalle de Rincón Little" style="width: 100%; border-radius: var(--border-radius-lg); box-shadow: 0 20px 50px rgba(0,0,0,0.1);">
                    </div>
                    <div class="anatomy-points">
                        <div class="anatomy-point fade-in-left delay-2">
                            <span class="point-number">01</span>
                            <div>
                                <h4 style="font-family: var(--font-heading); font-size: 1.2rem; color: var(--color-text-main); margin-bottom: 5px;">Madera y Elementos Naturales</h4>
                                <p style="color: var(--color-text-light); font-size: 0.95rem; line-height: 1.6;">Evitamos los plásticos y colores estridentes. Nuestros materiales conectan a los niños con la tierra y el juego orgánico.</p>
                            </div>
                        </div>
                        <div class="anatomy-point fade-in-left delay-3">
                            <span class="point-number">02</span>
                            <div>
                                <h4 style="font-family: var(--font-heading); font-size: 1.2rem; color: var(--color-text-main); margin-bottom: 5px;">Estética Impecable</h4>
                                <p style="color: var(--color-text-light); font-size: 0.95rem; line-height: 1.6;">Cada rincón se diseña para integrarse perfectamente en la decoración de tu evento, aportando belleza en lugar de ruido visual.</p>
                            </div>
                        </div>
                        <div class="anatomy-point fade-in-left delay-4">
                            <span class="point-number">03</span>
                            <div>
                                <h4 style="font-family: var(--font-heading); font-size: 1.2rem; color: var(--color-text-main); margin-bottom: 5px;">Juego Heurístico</h4>
                                <p style="color: var(--color-text-light); font-size: 0.95rem; line-height: 1.6;">Piezas sueltas y materiales desestructurados que fomentan la imaginación sin límites ni reglas preestablecidas.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3. El Recorrido del Servicio (Timeline) -->
        <section class="timeline-section">
            <div class="container fade-in-up">
                <div class="text-center">
                    <h2 style="font-family: var(--font-heading); font-size: 2.5rem; color: var(--color-accent-primary);">El Recorrido del Servicio</h2>
                    <p style="color: var(--color-text-light); margin-top: 10px; font-size: 1.1rem;">Cómo trabajamos para hacer realidad tu evento</p>
                </div>

                <div class="timeline-container">
                    <div class="timeline-step fade-in-up delay-1">
                        <h3 class="timeline-title">1. Inspiración y Conexión</h3>
                        <p class="timeline-desc">Nos contáis vuestra idea, el estilo de evento que queréis crear y las edades de los pequeños invitados. Nosotras captamos vuestra esencia.</p>
                    </div>
                    <div class="timeline-step fade-in-up delay-2">
                        <h3 class="timeline-title">2. Curaduría y Diseño</h3>
                        <p class="timeline-desc">Seleccionamos cuidadosamente los materiales, los tipis y los elementos sensoriales que mejor encajan con la paleta de colores y el espacio elegido.</p>
                    </div>
                    <div class="timeline-step fade-in-up delay-3">
                        <h3 class="timeline-title">3. El Montaje Mágico</h3>
                        <p class="timeline-desc">Llegamos antes que los invitados para transformar el espacio. Todo quedará montado y listo para brillar antes de que comience la fiesta.</p>
                    </div>
                    <div class="timeline-step fade-in-up delay-4">
                        <h3 class="timeline-title">4. Acompañamiento Silencioso</h3>
                        <p class="timeline-desc">Durante el evento, nuestras guías estarán presentes en un segundo plano, cuidando que la magia fluya y que los niños disfruten con total seguridad.</p>
                    </div>
                    <div class="timeline-step fade-in-up delay-5">
                        <h3 class="timeline-title">5. Desmontaje Invisible</h3>
                        <p class="timeline-desc">Al terminar, recogemos todo el universo Little sin hacer ruido, dejándoos únicamente con el recuerdo de un evento perfecto.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- 4. Catálogo de Universos -->
        <section class="universes-section">
            <div class="container">
                <div class="text-center fade-in-up">
                    <h2 style="font-family: var(--font-heading); font-size: 2.5rem; color: var(--color-accent-primary);">Nuestros Universos</h2>
                    <p style="color: var(--color-text-light); margin-top: 10px; font-size: 1.1rem;">Rincones temáticos preparados para soñar</p>
                </div>

                <div class="universes-grid">
                    <div class="universe-card fade-in-up delay-1">
                        <img src="https://images.unsplash.com/photo-1543328224-ca4ec1cae866?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Universo Sensorial" class="universe-img">
                        <div class="universe-content">
                            <h3 style="font-family: var(--font-heading); font-size: 1.4rem; color: var(--color-text-main); margin-bottom: 10px;">Universo Sensorial</h3>
                            <p style="color: var(--color-text-light); font-size: 0.95rem;">Exploración de texturas, trasvases y bandejas de experimentación para las mentes más pequeñas.</p>
                        </div>
                    </div>
                    <div class="universe-card fade-in-up delay-2">
                        <img src="https://images.unsplash.com/photo-1510798831971-661eb04b3739?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Universo Tipi" class="universe-img">
                        <div class="universe-content">
                            <h3 style="font-family: var(--font-heading); font-size: 1.4rem; color: var(--color-text-main); margin-bottom: 10px;">Universo Bosque de Tipis</h3>
                            <p style="color: var(--color-text-light); font-size: 0.95rem;">Un refugio estético para leer, descansar o esconderse, iluminado con luces de hada y cojines.</p>
                        </div>
                    </div>
                    <div class="universe-card fade-in-up delay-3">
                        <img src="https://images.unsplash.com/photo-1662998634568-bdcc5949e250?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Universo Construcción" class="universe-img">
                        <div class="universe-content">
                            <h3 style="font-family: var(--font-heading); font-size: 1.4rem; color: var(--color-text-main); margin-bottom: 10px;">Universo Construcción</h3>
                            <p style="color: var(--color-text-light); font-size: 0.95rem;">Maderas gigantes, arcoíris Waldorf y piezas de encaje para los futuros arquitectos e inventores.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 5. Dynamic Link to Calendar -->
        <section class="dynamic-link-area fade-in-up">
            <div class="container">
                <h2 style="font-family: var(--font-heading); font-size: 2.5rem; margin-bottom: 15px;">¿Listo para preparar algo mágico?</h2>
                <p style="font-size: 1.2rem; opacity: 0.9; margin-bottom: 30px; font-weight: 300;">Consulta nuestra disponibilidad en el nuevo calendario interactivo</p>
                <a href="contacto.html" class="btn btn-primary" style="background: white; color: var(--color-accent-primary); border: none; padding: 15px 40px; font-size: 1.1rem; border-radius: 50px; font-weight: 500; box-shadow: 0 10px 20px rgba(0,0,0,0.1);">Ver Disponibilidad</a>
            </div>
        </section>

        <!-- FAQ Section -->
        <section class="section faq bg-light" style="padding: 60px 0;">
            <div class="container fade-in-up">
                <h2 style="color: var(--color-accent-primary); text-align: center; margin-bottom: 40px; font-size: 2.2rem;"
                    data-i18n="faq_title">Preguntas Frecuentes</h2>

                <div class="faq-grid"
                    style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
                    <div class="faq-item"
                        style="background: white; border-radius: 0; padding: 25px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); border-left: 4px solid var(--color-accent-primary);">
                        <h4 style="font-family: var(--font-heading); font-size: 1.1rem; margin-bottom: 10px; color: var(--color-text-main);"
                            data-i18n="faq_q1">¿Os desplazáis fuera de Palma?</h4>
                        <p style="color: var(--color-text-light); line-height: 1.6; font-size: 0.95rem;"
                            data-i18n="faq_a1">Sí, nos desplazamos por toda la isla de Mallorca. El traslado en Palma
                            capital y alrededores está incluido; zonas más alejadas pueden tener un pequeño recargo de
                            desplazamiento.</p>
                    </div>
                    <div class="faq-item"
                        style="background: white; border-radius: 0; padding: 25px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); border-left: 4px solid var(--color-accent-primary);">
                        <h4 style="font-family: var(--font-heading); font-size: 1.1rem; margin-bottom: 10px; color: var(--color-text-main);"
                            data-i18n="faq_q2">¿Con cuánto tiempo de antelación debo reservar?</h4>
                        <p style="color: var(--color-text-light); line-height: 1.6; font-size: 0.95rem;"
                            data-i18n="faq_a2">Para Grandes Eventos como Bodas o Comuniones te sugerimos reservar con al
                            menos 3 a 6 meses de antelación. Para cumpleaños, 3 o 4 semanas suele ser suficiente.</p>
                    </div>
                    <div class="faq-item"
                        style="background: white; border-radius: 0; padding: 25px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); border-left: 4px solid var(--color-accent-primary);">
                        <h4 style="font-family: var(--font-heading); font-size: 1.1rem; margin-bottom: 10px; color: var(--color-text-main);"
                            data-i18n="faq_q3">¿Qué edades abarca el Juego Libre?</h4>
                        <p style="color: var(--color-text-light); line-height: 1.6; font-size: 0.95rem;"
                            data-i18n="faq_a3">Nuestros rincones y materiales están adaptados principalmente para peques
                            desde que caminan hasta los 6-8 años, aunque siempre personalizamos según los invitados.</p>
                    </div>
                    <div class="faq-item"
                        style="background: white; border-radius: 0; padding: 25px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); border-left: 4px solid var(--color-accent-primary);">
                        <h4 style="font-family: var(--font-heading); font-size: 1.1rem; margin-bottom: 10px; color: var(--color-text-main);"
                            data-i18n="faq_q4">¿Cuidáis de los niños durante el banquete de bodas?</h4>
                        <p style="color: var(--color-text-light); line-height: 1.6; font-size: 0.95rem;"
                            data-i18n="faq_a4">¡Sí! Nuestras animadoras pueden estar presentes no solo en la zona de
                            Juego Libre, sino también dando soporte en la mesa de los niños durante el convite.</p>
                    </div>
                </div>

                <div style="text-align: center; margin-top: 40px;">
                    <a href="contacto.html" class="btn btn-primary"
                        style="padding: 12px 30px; font-size: 1.1rem; border-radius: 0;"
                        data-i18n="faq_contact_btn">Tengo otra duda, hablemos</a>
                </div>
            </div>
        </section>

    </main>
"@

$content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?s)<main class="page-main">.*?</main>', $newMain)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Servicios layout replaced smoothly!"
