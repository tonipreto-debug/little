import os
import re

html_files = [f for f in os.listdir('.') if f.endswith('.html')]

fa_link = '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />\n    <link rel="stylesheet" href="./css/style.css'

for file in html_files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1. Add FA link before style.css
    if 'font-awesome' not in content:
        content = content.replace('<link rel="stylesheet" href="./css/style.css', fa_link)
    
    # 2. Replace language selector text
    content = content.replace('id="current-lang-text">Español</span>', 'id="current-lang-text">ES</span>')
    content = content.replace('<li data-value="es">Español</li>', '<li data-value="es">ES</li>')
    content = content.replace('<li data-value="en">English</li>', '<li data-value="en">EN</li>')
    content = content.replace('<li data-value="de">Deutsch</li>', '<li data-value="de">DE</li>')
    content = content.replace('<li data-value="fr">Français</li>', '<li data-value="fr">FR</li>')
    content = content.replace('<li data-value="ca">Català</li>', '<li data-value="ca">CA</li>')

    # 3. Replace photo_camera and chat specifically in aria-label wrappers
    # Instagram usually wraps in: <a href="https://www.instagram.com/little_juegolibre"...
    # We can just look for class="material-symbols-rounded">photo_camera</span> and replace it
    content = content.replace(
        '<span\n                            class="material-symbols-rounded">photo_camera</span>', 
        '<i class="fa-brands fa-instagram" style="font-size: 26px;"></i>'
    )
    content = content.replace(
        '<span\n                            class="material-symbols-rounded">chat</span>', 
        '<i class="fa-brands fa-whatsapp" style="font-size: 26px;"></i>'
    )
    # Also handle single line
    content = content.replace(
        '<span class="material-symbols-rounded">photo_camera</span>', 
        '<i class="fa-brands fa-instagram" style="font-size: 26px;"></i>'
    )
    content = content.replace(
        '<span class="material-symbols-rounded">chat</span>', 
        '<i class="fa-brands fa-whatsapp" style="font-size: 26px;"></i>'
    )
    
    # For contacto.html specific
    content = content.replace(
        '<span class="material-symbols-rounded" style="margin-right: 8px;">photo_camera</span>',
        '<i class="fa-brands fa-instagram" style="font-size: 20px; margin-right: 8px;"></i>'
    )
    content = content.replace(
        '<span class="material-symbols-rounded" style="margin-right: 8px;">chat</span>',
        '<i class="fa-brands fa-whatsapp" style="font-size: 20px; margin-right: 8px;"></i>'
    )

    with open(file, 'w', encoding='utf-8') as f:
        f.write(content)
        print(f"Updated {file}")
