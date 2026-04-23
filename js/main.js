document.addEventListener('DOMContentLoaded', () => {

    // Set current year in footer
    document.getElementById('year').textContent = new Date().getFullYear();

    // Menu Toggle for Mobile
    const toggleBtn = document.getElementById('nav-toggle');
    const navMenu = document.getElementById('nav-menu');
    const navLinks = document.querySelectorAll('.nav-link');

    toggleBtn.addEventListener('click', () => {
        navMenu.classList.toggle('active');
        const icon = toggleBtn.querySelector('span');
        if (navMenu.classList.contains('active')) {
            icon.textContent = 'close';
        } else {
            icon.textContent = 'menu';
        }
    });

    // Close menu when clicking a link (but NOT the parent dropdown toggler on mobile)
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            const parentItem = link.closest('.nav-item.dropdown');
            const isInsideDropdown = link.closest('.dropdown-menu');

            if (parentItem && !isInsideDropdown) {
                // On MOBILE: first click opens dropdown, don't navigate yet
                if (window.innerWidth <= 991) {
                    // If already open → allow navigation to servicios.html
                    if (parentItem.classList.contains('open')) {
                        // Close dropdown and let the link navigate normally
                        parentItem.classList.remove('open');
                        // Don't preventDefault → browser follows href
                        return;
                    }
                    // First tap: just open the dropdown
                    e.preventDefault();
                    parentItem.classList.toggle('open');
                    return;
                }
                // On DESKTOP: hover handles dropdown via CSS — click navigates directly
                // Don't preventDefault → browser follows href to servicios.html
                return;
            }

            // Sub-links or other nav items: close the whole nav
            navMenu.classList.remove('active');
            toggleBtn.querySelector('span').textContent = 'menu';
            document.querySelectorAll('.nav-item.dropdown.open').forEach(el => el.classList.remove('open'));
        });
    });

    // Close any open dropdown when clicking outside of it
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.nav-item.dropdown')) {
            document.querySelectorAll('.nav-item.dropdown.open').forEach(el => el.classList.remove('open'));
        }
    });

    // Header Background on Scroll
    const header = document.getElementById('header');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }

        // --- NEW: Hide header on scroll down, show on scroll up ---
        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

        // Don't do anything if near the top
        if (scrollTop > 100) {
            if (scrollTop > lastScrollTop) {
                // Scrolling down -> hide header
                header.classList.add('header-hidden');
            } else {
                // Scrolling up -> show header
                header.classList.remove('header-hidden');
            }
        } else {
            // Always show header at the very top
            header.classList.remove('header-hidden');
        }

        lastScrollTop = scrollTop;
    });

    // Scroll Animations (Intersection Observer)
    const animateElements = document.querySelectorAll('.fade-in-up, .fade-in-left, .fade-in-right, .fade-in-down, .scale-up');

    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-show');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    animateElements.forEach(el => observer.observe(el));

    // Bono Regalo Popup Logic
    const bonoPopup = document.getElementById('bono-popup');
    const bonoCloseBtn = document.getElementById('bono-close-btn');

    if (bonoPopup) {
        // Show after 1 minute (60,000ms)
        setTimeout(() => {
            // Check if user has already seen it in this session to avoid annoyance every page load
            if (!sessionStorage.getItem('bonoPopupShown')) {
                bonoPopup.classList.add('show');
                sessionStorage.setItem('bonoPopupShown', 'true');
                
                // Auto-close after 10 seconds unless interacted with
                let autoCloseTimeout = setTimeout(() => {
                    bonoPopup.classList.remove('show');
                    document.body.style.overflow = '';
                }, 10000);

                bonoPopup.addEventListener('mouseenter', () => clearTimeout(autoCloseTimeout));
                bonoPopup.addEventListener('touchstart', () => clearTimeout(autoCloseTimeout), {passive: true});
            }
        }, 60000);

        if (bonoCloseBtn) {
            bonoCloseBtn.addEventListener('click', () => {
                bonoPopup.classList.remove('show');
                document.body.style.overflow = '';
            });
        }

        // Also ensure "SABER MÁS" restores body scroll if it's not a hard navigation
        const saberMasBtn = bonoPopup.querySelector('.btn-primary');
        if (saberMasBtn) {
            saberMasBtn.addEventListener('click', () => {
                document.body.style.overflow = '';
            });
        }
    }

    // --- WAVE TEXT ANIMATIONS ---
    window.initWaveText = function() {
        const waveElements = document.querySelectorAll('.animate-wave');
        waveElements.forEach(el => {
            const text = el.innerText.trim();
            if (!text) return;
            
            // Clear current content (which might be the raw translated string from language.js)
            el.innerHTML = '';
            
            // Rebuild with spans
            const words = text.split(' ');
            let charIndex = 0;
            
            words.forEach((word, wordIdx) => {
                const wordSpan = document.createElement('span');
                wordSpan.className = 'wave-word';
                
                for (let i = 0; i < word.length; i++) {
                    const charSpan = document.createElement('span');
                    charSpan.className = 'wave-char';
                    charSpan.textContent = word[i];
                    charSpan.style.animationDelay = `${charIndex * 0.04}s`; // Stagger delay
                    wordSpan.appendChild(charSpan);
                    charIndex++;
                }
                
                el.appendChild(wordSpan);
                if (wordIdx < words.length - 1) {
                    el.appendChild(document.createTextNode(' '));
                }
            });
            
            // Re-observe for animation trigger if scrolled out of view, or ensure it plays
            el.classList.remove('wave-active');
            if (typeof window.waveObserver !== 'undefined') {
                window.waveObserver.observe(el);
            }
        });
    };

    window.waveObserver = new IntersectionObserver((entries, obs) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('wave-active');
                obs.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    // Initialize after a tiny delay so translation finishes on first load
    setTimeout(() => {
        initWaveText();
    }, 100);

    // FAQ Accordion Toggle Logic
    window.toggleFaq = function(header) {
        const item = header.parentElement;
        const panel = item.querySelector('.faq-accordion-panel');
        const isActive = item.classList.contains('active');
        
        // Close other open items (Optional: comment out if you want multiple open)
        const allItems = document.querySelectorAll('.faq-accordion-item');
        allItems.forEach(i => {
            if (i !== item) {
                i.classList.remove('active');
                const otherPanel = i.querySelector('.faq-accordion-panel');
                if (otherPanel) otherPanel.style.maxHeight = null;
            }
        });
        
        // Toggle current item
        if (isActive) {
            item.classList.remove('active');
            panel.style.maxHeight = null;
        } else {
            item.classList.add('active');
            panel.style.maxHeight = panel.scrollHeight + "px";
        }
    };

    // --- Inyección Global de UI (WhatsApp y Cookies) ---
    // 1. WhatsApp Flotante
    if (!document.querySelector('.float-wa')) {
        const waBtn = document.createElement('a');
        waBtn.href = "https://wa.me/34603919414";
        waBtn.className = "float-wa";
        waBtn.target = "_blank";
        waBtn.setAttribute('aria-label', "Escríbenos por WhatsApp");
        waBtn.innerHTML = '<i class="fa-brands fa-whatsapp"></i>';
        document.body.appendChild(waBtn);
    }

    // 2. Banner de Cookies
    if (!localStorage.getItem('little_cookies_accepted') && !document.getElementById('cookieBanner')) {
        const cookieDiv = document.createElement('div');
        cookieDiv.className = 'cookie-banner';
        cookieDiv.id = 'cookieBanner';
        cookieDiv.innerHTML = `
            <div class="cookie-content">
                <p>Usamos galletas (cookies) propias y de terceros para darte la mejor experiencia en nuestra web. ✨</p>
                <div class="cookie-buttons">
                    <button id="acceptCookies" class="btn btn-primary" style="padding: 10px 20px; font-size: 0.85rem; border-radius: 30px;">¡Aceptar magia!</button>
                    <button id="declineCookies" style="background:none; border:none; color: var(--color-text-light); text-decoration: underline; font-size: 0.8rem; cursor:pointer;">No, gracias</button>
                </div>
            </div>
        `;
        document.body.appendChild(cookieDiv);
        
        // Mostrar con delay
        setTimeout(() => cookieDiv.classList.add('show'), 2000);

        // Lógica botones
        document.getElementById('acceptCookies').addEventListener('click', () => {
            localStorage.setItem('little_cookies_accepted', 'true');
            cookieDiv.classList.remove('show');
            setTimeout(() => cookieDiv.remove(), 500);
        });
        
        document.getElementById('declineCookies').addEventListener('click', () => {
            sessionStorage.setItem('little_cookies_accepted', 'declined'); // Expira al cerrar pestaña
            cookieDiv.classList.remove('show');
            setTimeout(() => cookieDiv.remove(), 500);
        });
    }

});
