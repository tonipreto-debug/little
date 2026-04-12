import os
from bs4 import BeautifulSoup
import json

base_dir = r'c:\Users\tonip\Desktop\LITTLE'
html_files = [f for f in os.listdir(base_dir) if f.endswith('.html')]

# Etiquetas que normalmente contienen texto
text_tags = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'span', 'a', 'button', 'li', 'label', 'strong', 'em', 'b']

missing_i18n = {}

for filename in html_files:
    # Leer archivo
    with open(os.path.join(base_dir, filename), 'r', encoding='utf-8') as file:
        soup = BeautifulSoup(file, 'html.parser')
    
    missing_for_file = []
    
    for tag in soup.find_all(text_tags):
        # Ignorar si tiene data-i18n
        if tag.has_attr('data-i18n'):
            continue
            
        # Ignorar si sus padres tienen data-i18n (suele pasar en spans dentro de un parrafo traducido)
        has_i18n_parent = False
        for parent in tag.parents:
            if parent.has_attr('data-i18n'):
                has_i18n_parent = True
                break
        
        if has_i18n_parent:
            continue
            
        # Obtener el texto directo, sin contar los hijos para no duplicar demasiado
        text = ''.join(tag.find_all(string=True, recursive=False)).strip()
        
        # Filtrar textos ruidosos, simbolos o scripts
        if len(text) > 1 and not text.isspace():
            missing_for_file.append(text)
            
    # deduplicate list keeping order
    seen = set()
    deduped = [x for x in missing_for_file if not (x in seen or seen.add(x))]
            
    if len(deduped) > 0:
        missing_i18n[filename] = deduped

with open(os.path.join(base_dir, 'missing_i18n.json'), 'w', encoding='utf-8') as f:
    json.dump(missing_i18n, f, ensure_ascii=False, indent=2)

print(f"Auditoria completada. Encontrados textos sueltos en {len(missing_i18n)} archivos.")
