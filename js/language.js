document.addEventListener('DOMContentLoaded', () => {

    // Get language from localStorage or default to 'es'
    let currentLang = localStorage.getItem('little_lang') || 'es';

    // Function to apply translations
    function translateDOM(lang) {
        if (!translations[lang]) return;

        const elements = document.querySelectorAll('[data-i18n]');
        elements.forEach(element => {
            const key = element.getAttribute('data-i18n');
            if (translations[lang][key]) {
                if (element.tagName.toLowerCase() === 'input' || element.tagName.toLowerCase() === 'textarea') {
                    if (element.placeholder) {
                        element.placeholder = translations[lang][key];
                    }
                } else {
                    element.innerHTML = translations[lang][key];
                }
            }
        });

        // Update document lang attribute
        document.documentElement.lang = lang;

        // Update custom selector UI if it exists
        const langTextSpan = document.getElementById('current-lang-text');
        if (langTextSpan) {
            const langNames = {
                'es': 'ES',
                'en': 'EN',
                'de': 'DE',
                'fr': 'FR',
                'ca': 'CA'
            };
            langTextSpan.textContent = langNames[lang] || 'ES';
        }

        // Re-initialize wave text if the function is available
        if (typeof window.initWaveText === 'function') {
            window.initWaveText();
        }
    }

    // Initial translation run
    if (typeof translations !== 'undefined') {
        translateDOM(currentLang);
    }

    // Custom language selector event listeners
    const languageSelected = document.getElementById('language-selected');
    const languageOptions = document.getElementById('language-options');

    if (languageSelected && languageOptions) {
        // Toggle options on click
        languageSelected.addEventListener('click', (e) => {
            e.stopPropagation();
            languageOptions.classList.toggle('show');
        });

        // Close options when clicking outside
        document.addEventListener('click', () => {
            languageOptions.classList.remove('show');
        });

        // Handle option selection
        const optionsList = languageOptions.querySelectorAll('li');
        optionsList.forEach(option => {
            option.addEventListener('click', (e) => {
                const newLang = option.getAttribute('data-value');
                localStorage.setItem('little_lang', newLang);
                translateDOM(newLang);
                languageOptions.classList.remove('show');
            });
        });
    }
});
