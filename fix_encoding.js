const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'js', 'translations.js');
let content = fs.readFileSync(filePath, 'utf8');

const mapping = {
    'á': 'á',
    'é': 'é',
    'í': 'í',
    'ó': 'ó',
    'ú': 'ú',
    'ñ': 'ñ',
    'ü': 'ü',
    '·': '·',
    '¡': '¡',
    '¿': '¿',
    'á': 'á',
    'é': 'é',
    'í': 'í',
    'ó': 'ó',
    'ú': 'ú',
    'ñ': 'ñ',
    'ü': 'ü',
    '—': '—',
    '–': '–',
    '…': '…',
    'Í‚': '',
    'Í': 'í' // Catch-all for remaining single-byte corruption if needed
};

// Sort keys by length descending to prevent partial matches
const sortedKeys = Object.keys(mapping).sort((a, b) => b.length - a.length);

for (const key of sortedKeys) {
    const value = mapping[key];
    content = content.split(key).join(value);
}

fs.writeFileSync(filePath, content, 'utf8');
console.log('Successfully repaired encoding in translations.js');
