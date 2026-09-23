export function cambiarImagenConFlip() {
    // Seleccionar todos los contenedores de flip
    const flipContainers = document.querySelectorAll('.flip-container');

    flipContainers.forEach(container => {
        const imagenTrasera = container.querySelector('.back img');
        const imagenFrontal = container.querySelector('.front img');

        // 1. Si no hay cara trasera o no hay imagen frontal/trasera, es un escudo estático (inmune)
        if (!imagenTrasera || !imagenFrontal) return;

        // 2. Si la imagen trasera es la misma que la frontal (fallback de escudo), también es inmune
        if (imagenTrasera.src === imagenFrontal.src) return;

        const flippers = container.querySelectorAll('.flipper');

        flippers.forEach(flipper => {
            // Quitar clase si ya estaba aplicada
            flipper.classList.remove('flipping');

            // Forzar reflow para reiniciar la animación
            void flipper.offsetHeight;

            // Añadir la clase para empezar el volteo
            flipper.classList.add('flipping');

            // Cambiar la imagen frontal a la trasera después del flip
            setTimeout(() => {
                if (imagenFrontal && imagenTrasera) {
                    imagenFrontal.src = imagenTrasera.src;
                }
            }, 600); // Ajusta según la duración de tu animación en CSS
        });
    });
}