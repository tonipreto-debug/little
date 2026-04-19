/**
 * globe.js - 3D rotating sphere | INTENSE RED + HIGH-CONTRAST TEXT
 * Texture: canvas-drawn (no external image needed)
 * All .globe-canvas share the same rotation angle.
 */
(function () {
    'use strict';

    const CDN   = 'https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.min.js';

    // Deep-saturated coral — lights will brighten it to the right hue
    const BG    = '#B82020';   // dark-saturated base colour
    const SPEED = 0.006;

    let globalAngle   = 0;
    let speedOverride = null;

    /* ── Boot ─────────────────────────────────────────── */
    function boot() {
        const canvases = [...document.querySelectorAll('.globe-canvas')];
        if (!canvases.length) return;
        if (window.THREE) { init(canvases); return; }
        const s = document.createElement('script');
        s.src   = CDN;
        s.onload  = () => init(canvases);
        s.onerror = () => canvases.forEach(fallback2D);
        document.head.appendChild(s);
    }

    /* ── Init ─────────────────────────────────────────── */
    function init(canvases) {
        const ready = document.fonts ? document.fonts.ready : Promise.resolve();
        ready.then(() => {
            const tex = buildTexture();
            const instances = canvases.map(c => makeInstance(c, tex)).filter(Boolean);

            canvases.forEach(c => {
                c.addEventListener('mouseenter', () => { speedOverride = 0.030; });
                c.addEventListener('mouseleave', () => { speedOverride = null;  });
            });

            let rafId;
            function loop() {
                rafId        = requestAnimationFrame(loop);
                globalAngle += speedOverride || SPEED;
                instances.forEach(({ renderer, scene, camera, mesh }) => {
                    mesh.rotation.y = globalAngle;
                    renderer.render(scene, camera);
                });
            }
            loop();

            document.addEventListener('visibilitychange', () => {
                if (document.hidden) cancelAnimationFrame(rafId);
                else loop();
            });
        });
    }

    /* ── Texture generator ─────────────────────────────── */
    function buildTexture() {
        const W = 1024, H = 512;
        const cv = document.createElement('canvas');
        cv.width = W; cv.height = H;
        const ctx = cv.getContext('2d');

        // Solid deep-red base (lights will warm it to coral)
        ctx.fillStyle = BG;
        ctx.fillRect(0, 0, W, H);

        // Subtle pole darkening for depth — very slight
        const vGrad = ctx.createLinearGradient(0, 0, 0, H);
        vGrad.addColorStop(0,    'rgba(0,0,0,0.20)');
        vGrad.addColorStop(0.30, 'rgba(0,0,0,0)');
        vGrad.addColorStop(0.70, 'rgba(0,0,0,0)');
        vGrad.addColorStop(1,    'rgba(0,0,0,0.20)');
        ctx.fillStyle = vGrad;
        ctx.fillRect(0, 0, W, H);

        // Two logo copies for seamless horizontal wrap
        drawLogo(ctx, W / 4,     H / 2);
        drawLogo(ctx, W * 3 / 4, H / 2);

        const tex = new THREE.CanvasTexture(cv);
        tex.wrapS = THREE.RepeatWrapping;
        tex.repeat.set(1, 1);
        return tex;
    }

    /* ── Logo painter ─────────────────────────────────── */
    function drawLogo(ctx, cx, cy) {
        ctx.save();
        ctx.translate(cx, cy);

        const R = 152;

        // ── White arcs
        ctx.strokeStyle = 'rgba(255,255,255,0.95)';
        ctx.lineWidth   = 6;
        ctx.lineCap     = 'round';

        ctx.beginPath();
        ctx.arc(0, 0, R, Math.PI * 1.17, Math.PI * 1.83);
        ctx.stroke();

        ctx.beginPath();
        ctx.arc(0, 0, R, Math.PI * 0.17, Math.PI * 0.83);
        ctx.stroke();

        // ── "Little" — BIG, bold italic, white with strong shadow
        ctx.fillStyle    = 'white';
        ctx.textAlign    = 'center';
        ctx.textBaseline = 'alphabetic';
        ctx.shadowColor  = 'rgba(0,0,0,0.55)';
        ctx.shadowBlur   = 10;
        ctx.shadowOffsetX = 0;
        ctx.shadowOffsetY = 3;
        ctx.font = 'italic bold 100px "Playfair Display", Georgia, "Times New Roman", serif';
        ctx.fillText('Little', 0, 28);

        // ── "JUEGO LIBRE" — wider tracking, clear shadow
        ctx.font         = 'bold 21px "Montserrat", Arial, sans-serif';
        ctx.textBaseline = 'top';
        ctx.shadowBlur   = 6;
        ctx.shadowOffsetY = 2;
        ctx.fillText('JUEGO  LIBRE', 0, 44);

        ctx.restore();
    }

    /* ── Instance factory ─────────────────────────────── */
    function makeInstance(canvas, tex) {
        const size = parseInt(canvas.dataset.size) || 200;
        canvas.width  = size;
        canvas.height = size;
        canvas.style.width  = size + 'px';
        canvas.style.height = size + 'px';

        const renderer = new THREE.WebGLRenderer({ canvas, alpha: true, antialias: true });
        renderer.setPixelRatio(Math.min(devicePixelRatio, 2));
        renderer.setSize(size, size);
        renderer.toneMapping         = THREE.ACESFilmicToneMapping;
        // Exposure ~2.0: bright enough to bring dark-red base to vivid coral
        renderer.toneMappingExposure = 2.0;

        const scene  = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(42, 1, 0.1, 50);
        camera.position.z = 2.85;

        // White tint = texture colour shows exactly as painted
        // Emissive adds a glow in the darkest zones (prevents pure black)
        const mat = new THREE.MeshPhongMaterial({
            map:               tex,
            color:             new THREE.Color(0xffffff),
            shininess:         70,
            specular:          new THREE.Color(0xffd8d0),
            emissive:          new THREE.Color(0x6a0808),
            emissiveIntensity: 0.30,
        });

        const mesh = new THREE.Mesh(new THREE.SphereGeometry(1, 128, 128), mat);
        mesh.rotation.x = 0.22;
        scene.add(mesh);

        // 1. Low ambient — lets shadows be deep (more drama / saturation)
        scene.add(new THREE.AmbientLight(0xffe0d0, 0.35));

        // 2. Key — strong, warm-white
        const key = new THREE.DirectionalLight(0xfffaf5, 3.2);
        key.position.set(-2, 3, 3.5);
        scene.add(key);

        // 3. Fill — right, warm but subdued
        const fill = new THREE.DirectionalLight(0xffcdb8, 0.40);
        fill.position.set(2.5, -0.3, 1.5);
        scene.add(fill);

        // 4. Coral rim — saturated coral back-halo
        const rim = new THREE.PointLight(0xE05F59, 7.0, 9);
        rim.position.set(0, -0.5, -3.5);
        scene.add(rim);

        // 5. Front sparkle — tiny, brightens the logo face
        const front = new THREE.PointLight(0xfff5f0, 1.0, 5);
        front.position.set(0.3, 0.5, 3.0);
        scene.add(front);

        return { renderer, scene, camera, mesh };
    }

    /* ── Fallback ─────────────────────────────────────── */
    function fallback2D(canvas) {
        const s = parseInt(canvas.dataset.size) || 200;
        canvas.width = canvas.height = s;
        const ctx = canvas.getContext('2d');
        if (!ctx) return;
        const r = s / 2;
        const g = ctx.createRadialGradient(r * 0.55, r * 0.38, r * 0.04, r, r, r);
        g.addColorStop(0,    '#ff9080');
        g.addColorStop(0.35, '#E05F59');
        g.addColorStop(1,    '#5a0808');
        ctx.beginPath();
        ctx.arc(r, r, r * 0.93, 0, Math.PI * 2);
        ctx.fillStyle = g;
        ctx.fill();
        ctx.fillStyle = 'white';
        ctx.font = `italic bold ${r * 0.48}px Georgia, serif`;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.shadowColor = 'rgba(0,0,0,0.4)';
        ctx.shadowBlur = 6;
        ctx.fillText('Little', r, r);
    }

    if (document.readyState === 'loading')
        document.addEventListener('DOMContentLoaded', boot);
    else boot();
})();
