document.addEventListener("DOMContentLoaded", () => {
    const fondo = document.getElementById('fondo-web');
    const tamanoPunto = 40; // Coincide con los 40px del CSS

    function generarPuntos() {
        if (!fondo) return;
        fondo.innerHTML = ''; // Limpiar fondo
        
        // Calcular cuántas columnas y filas se necesitan para llenar la pantalla
        const columnas = Math.ceil(window.innerWidth / tamanoPunto);
        const filas = Math.ceil(window.innerHeight / tamanoPunto);
        const totalPuntos = columnas * filas;

        // Crear fragmento en memoria para mejor rendimiento
        const fragmento = document.createDocumentFragment();

        for (let i = 0; i < totalPuntos; i++) {
            const span = document.createElement('span');

            // Al pasar el ratón por encima del punto
            span.addEventListener('mouseenter', () => {
                span.classList.add('activo');
                // Quitar la clase activo después de 500ms para iniciar la desvanecida
                setTimeout(() => {
                    span.classList.remove('activo');
                }, 500);
            });

            fragmento.appendChild(span);
        }

        fondo.appendChild(fragmento);
    }

    // Generar al cargar
    generarPuntos();

    // Regenerar si la ventana cambia de tamaño
    let timeoutResize;
    window.addEventListener('resize', () => {
        clearTimeout(timeoutResize);
        timeoutResize = setTimeout(generarPuntos, 200);
    });
});