window.addEventListener('DOMContentLoaded', () => {
    const links = document.querySelectorAll('#selector a[href^="#"]');
    const sections = document.querySelectorAll('.content-section');

    function mostrarSeccionDesdeHash() {
        const hash = window.location.hash;
        let targetSection = null;
        let targetLink = null;

        // 1. Intentar buscar por Hash
        if (hash) {
            targetSection = document.querySelector(hash);
            targetLink = document.querySelector(`#selector a[href="${hash}"]`);
        }

        // 2. FALLBACK: Si no hay hash, o el hash no existe/no es de nuestras secciones
        if (!hash || !targetSection || !targetSection.classList.contains('content-section')) {
            targetSection = sections[0];
            targetLink = links[0];
        }

        console.log(sections, targetSection, links, targetLink);


        // 3. Aplicar cambios (siempre que existan secciones en la página)
        if (targetSection) {
            links.forEach(l => l.classList.remove('active'));
            sections.forEach(s => s.classList.remove('active'));

            targetSection.classList.add('active');
            if (targetLink) targetLink.classList.add('active');
        }
    }

    // Escuchar clics (opcional: e.preventDefault si no quieres salto de scroll)
    links.forEach(link => {
        link.addEventListener('click', (e) => {
            // Si quieres que el cambio sea instantáneo sin saltos, descomenta:
            // e.preventDefault();
            // history.pushState(null, null, link.getAttribute('href'));
            // mostrarSeccionDesdeHash();
        });
    });

    window.addEventListener('hashchange', mostrarSeccionDesdeHash);

    // Ejecución inicial
    requestAnimationFrame(mostrarSeccionDesdeHash);
});