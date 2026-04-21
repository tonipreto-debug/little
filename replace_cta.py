import sys

file_path = r'c:\Users\tonip\Desktop\LITTLE\juego-libre-interior.html'

with open(file_path, 'r', encoding='utf-8') as f:
    text = f.read()

# Define start and end exactly. We can just use split and join.
start_marker = '<!-- ===== LIGHT ANIMATION SECTION ===== -->'
end_marker = '</section>\n    </main>'

if start_marker in text and end_marker in text:
    start_idx = text.find(start_marker)
    end_idx = text.find(end_marker) + len('</section>\n')
    
    new_content = """<!-- ===== CTA ===== -->
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
"""
    
    final_text = text[:start_idx] + new_content + text[end_idx:]
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(final_text)
    print("Replaced section gracefully.")
else:
    print("Could not find markers.")
