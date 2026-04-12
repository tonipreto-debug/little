import os, json, re

html_files = [f for f in os.listdir('.') if f.endswith('.html')]
for f in html_files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Replace footer logo
    new_content = content.replace('src="./assets/logo.png" alt="Little Juego Libre" class="footer-logo-img"', 'src="./assets/logo-coral.jpg" alt="Little Juego Libre" class="footer-logo-img"')
    new_content = new_content.replace('src="assets/logo.png" alt="Little Juego Libre" class="footer-logo-img"', 'src="assets/logo-coral.jpg" alt="Little Juego Libre" class="footer-logo-img"')

    if new_content != content:
        with open(f, 'w', encoding='utf-8') as file:
            file.write(new_content)
        print(f'Updated footer logo in {f}')

# Now translations.js
with open('js/translations.js', 'r', encoding='utf-8') as f:
    t_content = f.read()

# Replace ticker_2 in all languages
t_content = re.sub(r'"ticker_2":\s*".*?"', '"ticker_2": "CADA MES CAMBIAMOS DE TEMÁTICA"', t_content)

# Change 6 to 4 years of experience
t_content = re.sub(r'"ext_stats_3_num":\s*"6"', '"ext_stats_3_num": "4"', t_content)

with open('js/translations.js', 'w', encoding='utf-8') as f:
    f.write(t_content)
print('Updated translations.js')
