import re

file_path = "c:\\Users\\tonip\\Desktop\\LITTLE\\eventos.html"

with open(file_path, "r", encoding="utf-8") as f:
    html = f.read()

# Add CSS
css_to_add = """
        /* ======= PDF LAYOUT STYLES ======= */
        .pdf-bg { background-color: #fcf8f2; }
        .pdf-bg-alt { background-color: #f7f1e6; }
        .pdf-terracotta { color: #a05740 !important; }
        .pdf-title-container { text-align: center; margin-bottom: 50px; }
        .pdf-title { 
            font-family: var(--font-heading); 
            font-size: clamp(2rem, 4vw, 3rem); 
            color: #a05740; 
            letter-spacing: 2px; 
            text-transform: uppercase; 
            position: relative;
            display: inline-block;
            margin-bottom: 10px;
        }
        .pdf-title::before, .pdf-title::after {
            content: '';
            position: absolute;
            left: -40px; right: -40px;
            height: 1px;
            background: #a05740;
        }
        .pdf-title::before { top: -10px; }
        .pdf-title::after { bottom: -10px; }
        
        .pdf-subtitle {
            color: #A05740;
            font-size: 1.1rem;
            max-width: 600px;
            margin: 30px auto;
            opacity: 0.9;
        }

        /* Forma de Crear */
        .forma-crear-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            align-items: center;
        }
        .forma-text-col p {
            color: #a05740;
            font-size: 1.05rem;
            line-height: 1.8;
            margin-bottom: 25px;
        }
        .forma-text-col strong {
            font-weight: 700;
        }
        .forma-text-col .quote {
            font-family: var(--font-heading);
            font-style: italic;
            font-size: 1.4rem;
            text-align: center;
            margin-top: 40px;
        }
        .forma-img-col {
            position: relative;
            height: 500px;
        }
        .forma-arch-1 {
            position: absolute;
            top: 0; right: 0;
            width: 70%; height: 60%;
            border-radius: 200px 200px 0 0;
            object-fit: cover;
        }
        .forma-arch-2 {
            position: absolute;
            bottom: 0; left: 0;
            width: 60%; height: 75%;
            border-radius: 0 0 200px 200px;
            object-fit: cover;
        }

        /* Talleres Círculos */
        .talleres-row {
            display: flex;
            justify-content: center;
            gap: 5%;
            margin-top: 60px;
            flex-wrap: wrap;
        }
        .taller-circle-item {
            text-align: center;
            width: 200px;
            margin-bottom: 40px;
        }
        .taller-circle-title {
            color: #a05740;
            font-weight: 700;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
            min-height: 45px;
            display: flex;
            align-items: flex-end;
            justify-content: center;
            border-bottom: 1px solid #a05740;
            padding-bottom: 10px;
        }
        .taller-circle-img {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto;
            border: 4px solid #fff;
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
            transition: transform 0.4s ease;
        }
        .taller-circle-item:hover .taller-circle-img {
            transform: scale(1.05);
        }
        .btn-oval {
            display: inline-block;
            background-color: #ebdccc;
            color: #a05740;
            border-radius: 30px;
            padding: 8px 25px;
            font-size: 0.9rem;
            text-decoration: underline;
            text-decoration-color: #a05740;
            text-underline-offset: 4px;
            margin-top: 20px;
            transition: all 0.3s ease;
        }
        .btn-oval:hover {
            background-color: #d6cab9;
        }

        /* Timeline */
        .timeline-container {
            position: relative;
            margin: 80px 0;
            padding: 60px 0;
        }
        .timeline-line {
            position: absolute;
            top: 50%;
            left: 5%; right: 5%;
            height: 2px;
            background: #e8c6b8;
            z-index: 1;
        }
        .timeline-items {
            display: flex;
            justify-content: space-between;
            position: relative;
            z-index: 2;
        }
        .timeline-item {
            width: 140px;
            text-align: center;
            position: relative;
        }
        .timeline-item.top {
            transform: translateY(-40%);
        }
        .timeline-item.bottom {
            transform: translateY(40%);
        }
        .timeline-item::after {
            content: '';
            position: absolute;
            width: 14px; height: 14px;
            background: #e8c6b8;
            border-radius: 50%;
            left: 50%;
            transform: translateX(-50%);
        }
        .timeline-item.top::after { bottom: -47px; }
        .timeline-item.bottom::after { top: -47px; }
        
        .timeline-title {
            color: #a05740;
            font-weight: 700;
            font-size: 1rem;
            text-transform: uppercase;
            margin-bottom: 10px;
            min-height: 40px;
        }
        .timeline-img {
            width: 120px; height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 10px auto;
            border: 3px solid #fff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        .timeline-desc {
            color: #a05740;
            font-size: 0.85rem;
            line-height: 1.4;
        }

        /* Estacion Sensorial */
        .sensorial-box {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: center;
        }
        .sensorial-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .sens-arch {
            width: 100%;
            object-fit: cover;
        }
        .sens-arch-p1 { border-radius: 100px 100px 20px 20px; height: 300px; }
        .sens-arch-p2 { border-radius: 100px 100px 20px 20px; height: 350px; }
        .sens-arch-p3 { border-radius: 20px 20px 100px 100px; height: 250px; }
        .sens-arch-p4 { border-radius: 20px 20px 100px 100px; height: 200px; }

"""
html = html.replace("/* ======= EL ALMA (QUIENES SOMOS) ======= */", css_to_add + "\n        /* ======= EL ALMA (QUIENES SOMOS) ======= */")

# Remove Mobile Overrides that conflicts and add new
mobile_updates = """
        @media (max-width: 900px) {
            .forma-crear-grid { grid-template-columns: 1fr; }
            .forma-img-col { height: 400px; }
            .timeline-line { display: none; }
            .timeline-items { flex-direction: column; align-items: center; gap: 40px; }
            .timeline-item.top, .timeline-item.bottom { transform: none; }
            .timeline-item.top::after, .timeline-item.bottom::after { display: none; }
            .sensorial-box { grid-template-columns: 1fr; }
            .pdf-title::before, .pdf-title::after { display: none; }
        }
"""
html = html.replace("/* ======= MOBILE OVERRIDES ======= */", "/* ======= MOBILE OVERRIDES ======= */\n" + mobile_updates)


new_html_content = """
        <!-- ===== NUESTRA FORMA DE CREAR (PDF STYLE) ===== -->
        <section class="alma-section pdf-bg">
            <div class="container reveal-up">
                <div class="pdf-title-container">
                    <h2 class="pdf-title">Nuestra Forma<br>de Crear</h2>
                </div>
                <div class="forma-crear-grid">
                    <div class="forma-text-col">
                        <p>Nuestro trabajo nace de la <strong>sensibilidad</strong>, la <strong>experiencia</strong> y el cuidado por lo bonito.</p>
                        <p>Creamos <strong>propuestas</strong> abiertas, con materiales elegidos con <strong>intención</strong> y espacios pensados para invitar a la <strong>curiosidad</strong>, la <strong>calma</strong> y la <strong>autonomía</strong>.</p>
                        <p>Nos gusta <strong>acompañar</strong> sin dirigir, dejar espacio para que cada peque explore, imagine y descubra a su manera.</p>
                        <p>Porque no se trata solo de entretener, sino de <strong>vivirlo</strong>.<br>De <strong>crear</strong> sin prisas, sin ruido… y dejar que lo más bonito pase de forma espontánea.</p>
                        <p class="quote">“Creamos el evento que ellos también recordarán”</p>
                    </div>
                    <div class="forma-img-col">
                        <img src="./assets/evento-mockup-corporativo.png" class="forma-arch-1">
                        <img src="./assets/evento-mockup-bautizos.png" class="forma-arch-2">
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== TIPOS DE EVENTOS ORIGINALES ===== -->
        <section class="event-types-section pdf-bg-alt" id="tipos-evento" style="padding: 100px 0;">
            <div class="container">
                <div class="text-center reveal-up" style="margin-bottom: 70px;">
                    <div class="pdf-title-container"><h2 class="pdf-title">Tipos de Eventos</h2></div>
                    <p style="color: #a05740; max-width: 540px; margin: 0 auto; line-height: 1.75;">Cada evento es único. Nos adaptamos a ti, a tu espacio y a los pequeños que lo habitarán.</p>
                </div>

                <!-- Row 1: Bodas y Comuniones -->
                <div class="editorial-row reveal-up" style="background: white; padding: 40px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.03);">
                    <div class="editorial-img-col">
                        <div class="ed-img-wrap" style="border-radius: 20px;">
                            <img loading="lazy" decoding="async" src="./assets/eventos-hero-1.jpg" alt="Rincón infantil elegante en boda">
                        </div>
                    </div>
                    <div class="editorial-text-col">
                        <span class="ed-eyebrow" style="color: #a05740;">Evento 01</span>
                        <h2 class="ed-title" style="color: #a05740;">Bodas &amp; Comuniones</h2>
                        <p class="ed-desc">Los adultos celebran, los pequeños también. Diseñamos un rincón infantil integrado en vuestra boda o comunión para que los niños vivan el momento a su ritmo, con seguridad y sin interrumpir la magia del día grande.</p>
                        <ul class="ed-features" style="opacity:0.8;">
                            <li>Zona de juego sensorial personalizada</li>
                            <li>Estación de arte y creación libre</li>
                            <li>Mobiliario de madera y mimbre natural</li>
                            <li>Montaje y desmontaje incluidos</li>
                            <li>Acompañamiento profesional durante el evento</li>
                        </ul>
                    </div>
                </div>

                <!-- Row 2: Comuniones y Bautizos (reverse) -->
                <div class="editorial-row reverse reveal-up" style="background: white; padding: 40px; border-radius: 20px; margin-top: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.03);">
                    <div class="editorial-img-col">
                        <div class="ed-img-wrap" style="border-radius: 20px;">
                            <img loading="lazy" decoding="async" src="./assets/eventos-hero-2.jpg" alt="Rincón infantil celebraciones familiares">
                        </div>
                    </div>
                    <div class="editorial-text-col">
                        <span class="ed-eyebrow" style="color: #a05740;">Evento 02</span>
                        <h2 class="ed-title" style="color: #a05740;">Bautizos &amp; Fiestas Familiares</h2>
                        <p class="ed-desc">Cada celebración familiar merece un espacio donde los pequeños se sientan parte de algo especial. Creamos rincones adaptados a distintos grupos de edad, integrando el juego libre como protagonista natural del día.</p>
                        <ul class="ed-features" style="opacity:0.8;">
                            <li>Adaptación a interior o exterior</li>
                            <li>Personalización temática y cromática</li>
                            <li>Actividades sensoriales por edades</li>
                            <li>Hasta 40 niños participantes</li>
                        </ul>
                    </div>
                </div>
                
                <!-- Row 3: Corporativos -->
                <div class="editorial-row reveal-up" style="background: white; padding: 40px; border-radius: 20px; margin-top: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.03);">
                    <div class="editorial-img-col">
                        <div class="ed-img-wrap" style="border-radius: 20px;">
                            <img loading="lazy" decoding="async" src="./assets/eventos-hero-3.jpg" alt="Rincón infantil corporativo">
                        </div>
                    </div>
                    <div class="editorial-text-col">
                        <span class="ed-eyebrow" style="color: #a05740;">Evento 03</span>
                        <h2 class="ed-title" style="color: #a05740;">Eventos Escolares<br>&amp; Corporativos</h2>
                        <p class="ed-desc">Desde jornadas de puertas abiertas hasta ferias infantiles y días especiales en centros educativos — aportamos propuestas artísticas y sensoriales que conectan con la infancia de una manera auténtica y significativa.</p>
                        <ul class="ed-features" style="opacity:0.8;">
                            <li>Propuestas artísticas y sensoriales grupales</li>
                            <li>Adaptado a entornos educativos y empresariales</li>
                            <li>Materiales biodegradables y seguros</li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== TALLERES (PDF STYLE CIRCLES) ===== -->
        <section class="talleres-section pdf-bg" style="padding: 100px 0;">
            <div class="container reveal-up">
                <div class="pdf-title-container">
                    <h2 class="pdf-title">Talleres</h2>
                    <p class="pdf-subtitle">Diseñamos talleres <strong>creativos</strong> que pueden adaptarse al estilo y concepto de cada evento.</p>
                </div>
                
                <div class="talleres-row">
                    <div class="taller-circle-item">
                        <div class="taller-circle-title">Gorras</div>
                        <img src="./assets/evento-gorras.png" alt="Gorras" class="taller-circle-img">
                        <a href="contacto.html" class="btn-oval">Saber más</a>
                    </div>
                    <div class="taller-circle-item">
                        <div class="taller-circle-title">Gafas</div>
                        <img src="./assets/evento-gafas.png" alt="Gafas" class="taller-circle-img">
                        <a href="contacto.html" class="btn-oval">Saber más</a>
                    </div>
                    <div class="taller-circle-item">
                        <div class="taller-circle-title">Capas de<br>Superhéroe</div>
                        <img src="./assets/evento-capas.png" alt="Capas" class="taller-circle-img">
                        <a href="contacto.html" class="btn-oval">Saber más</a>
                    </div>
                    <div class="taller-circle-item">
                        <div class="taller-circle-title">Sensorial<br><span style="font-size:0.7rem; font-weight:normal; letter-spacing:0;">peques 0-4</span></div>
                        <img src="./assets/evento-sensorial.png" alt="Sensorial" class="taller-circle-img">
                        <a href="contacto.html" class="btn-oval">Saber más</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== ESTACION SENSORIAL DETAIL ===== -->
        <section class="pdf-bg-alt" style="padding: 100px 0;">
            <div class="container reveal-up">
                <div class="sensorial-box">
                    <div class="forma-text-col">
                        <div class="pdf-title-container" style="text-align:left;"><h2 class="pdf-title" style="margin-left:40px;">Estación Sensorial</h2></div>
                        <p class="quote" style="text-align:left; color:#a05740; font-size:1.1rem; margin-top:-30px;">"Zona de experimentación para los más pequeños"</p>
                        <p>Los invitados más pequeños también merecen una experiencia a su medida. Diseñamos un rincón de <strong>calma y exploración</strong> para bebés y niños de <strong>0 a 4 años</strong>, donde los materiales naturales, las texturas y los elementos sensoriales son los protagonistas.</p>
                        <p>Un <strong>espacio seguro y estético</strong> que respeta sus ritmos, fomentando la <strong>curiosidad</strong> y el asombro en un ambiente <strong>relajado</strong> dentro de la celebración.</p>
                        <strong style="color:#a05740; display:block; margin: 30px 0 15px;">INCLUYE:</strong>
                        <ul style="color:#a05740; padding-left:20px; line-height:1.8;">
                            <li>Propuestas sensoriales con bases comestibles, hechas por nosotras y sin azúcar.</li>
                            <li>Mobiliario a su altura.</li>
                            <li>Temática personalizada.</li>
                            <li>Acompañamiento durante el taller.</li>
                        </ul>
                    </div>
                    <div class="sensorial-grid">
                        <img src="./assets/evento-sensorial.png" class="sens-arch sens-arch-p1">
                        <img src="./assets/evento-sensorial.png" class="sens-arch sens-arch-p2">
                        <img src="./assets/evento-sensorial.png" class="sens-arch sens-arch-p3">
                        <img src="./assets/evento-sensorial.png" class="sens-arch sens-arch-p4">
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== PERSONALIZA VUESTRA EXPERIENCIA (TIMELINE) ===== -->
        <section class="pdf-bg" style="padding: 100px 0;">
            <div class="container reveal-up">
                <div class="pdf-title-container">
                    <h2 class="pdf-title">Personaliza Vuestra Experiencia</h2>
                    <p class="pdf-subtitle"><strong>Rincones con alma</strong> para completar una experiencia diseñada exclusivamente para vosotros.</p>
                </div>
                
                <div class="timeline-container">
                    <div class="timeline-line"></div>
                    <div class="timeline-items">
                        <div class="timeline-item top">
                            <h3 class="timeline-title">Gymcana</h3>
                            <img src="./assets/evento-mockup-corporativo.png" class="timeline-img">
                            <p class="timeline-desc">Aventura en equipo personalizada.</p>
                        </div>
                        <div class="timeline-item bottom">
                            <h3 class="timeline-title">Zona Tipi</h3>
                            <img src="./assets/evento-mockup-bodas.png" class="timeline-img">
                            <p class="timeline-desc">Rincones de calma y materiales naturales.</p>
                        </div>
                        <div class="timeline-item top">
                            <h3 class="timeline-title">Bolsa de Tela</h3>
                            <img src="./assets/evento-gorras.png" class="timeline-img">
                            <p class="timeline-desc">Detalle creativo para llevar a casa.</p>
                        </div>
                        <div class="timeline-item bottom">
                            <h3 class="timeline-title">Manteles<br>Personalizados</h3>
                            <img src="./assets/evento-gafas.png" class="timeline-img">
                            <p class="timeline-desc">Colorear mientras nos divertimos.</p>
                        </div>
                        <div class="timeline-item top">
                            <h3 class="timeline-title">Álbum con<br>Polaroid</h3>
                            <img src="./assets/evento-capas.png" class="timeline-img">
                            <p class="timeline-desc">Fotos y dedicatorias de vuestro día.</p>
                        </div>
                        <div class="timeline-item bottom">
                            <h3 class="timeline-title">Cuadro de<br>Huellas</h3>
                            <img src="./assets/evento-sensorial.png" class="timeline-img">
                            <p class="timeline-desc">Un recuerdo artístico creado por los peques.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
"""

# Replace the block from <!-- ===== EL ALMA ===== --> to <!-- ===== LOGISTICA ===== -->
start_tag = "<!-- ===== EL ALMA ===== -->"
end_tag = "<!-- ===== LOGISTICA ===== -->"

start_idx = html.find(start_tag)
end_idx = html.find(end_tag)

if start_idx != -1 and end_idx != -1:
    html = html[:start_idx] + new_html_content + html[end_idx:]

with open(file_path, "w", encoding="utf-8") as f:
    f.write(html)

print("HTML and CSS successfully updated!")
