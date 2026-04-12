import os
import re

html_files = [f for f in os.listdir('.') if f.endswith('.html')]

globe_pattern = re.compile(r'(\s*<!--.*?3D GLOBE.*?-->)?\s*<div class="footer-globe-outer">.*?</div>\s*</div>', re.DOTALL)
script_pattern = re.compile(r'\s*<script defer src="\./js/globe\.js"></script>')

replacement = '\n                <img src="./assets/logo.png" alt="Little Juego Libre" class="footer-logo-img">'

for filepath in html_files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # The globe outer div has a canvas and a glow div inside.
    # Let's use a simpler pattern just replacing the known block.
    # We can match <div class="footer-globe-outer"> to its matching </div>.
    # Since it has nested divs? No, canvas and empty div.
    
    # Let's do a replace based on the comment and outer div.
    content = re.sub(
        r'\s*<!-- ✦ 3D GLOBE \(WebGL\) ✦ -->\s*<div class="footer-globe-outer">\s*<canvas.*?</canvas>\s*<div class="globe-ground-glow"></div>\s*</div>',
        replacement,
        content,
        flags=re.DOTALL
    )
    
    content = re.sub(script_pattern, '', content)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

print("Done.")
