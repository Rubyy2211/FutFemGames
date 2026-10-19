import { obtenerRachaPerfil } from '/static/usuarios/js/rachas.js';
import { handleAutocompletePlayer } from '/static/futfem/js/jugadora.js';
import { updateJugadoraPerfil } from '/static/usuarios/js/users.js';

// Obtenemos el ID del usuario del perfil (no necesariamente el mío)
const perfilId = document.getElementById('perfil-usuario-id').value;
const btnEditar = document.getElementById('btn-editar-jugadora');
const btnEditarEquipo = document.getElementById('btn-editar-equipo');
const displaySpan = document.getElementById('jugadora-nombre-display');
const inputContainer = document.getElementById('edit-input-container');
const inputField = document.getElementById('jugadora-input');
const equopinputField = document.getElementById('equipo-input');
const btnGuardarJugadora = document.getElementById('btn-guardar-jugadora');
const btnGuardarEquipo = document.getElementById('btn-guardar-equipo');
const usuarioH1 = document.getElementById('username');
const h1 = document.querySelector('#username-container h1')
const escudoContainer = document.getElementById('equipo-fav');
const escudo = escudoContainer.querySelector('img');

// Si el perfil es propio, permitimos editar el nombre de usuario
if (usuarioH1) {
    usuarioH1.addEventListener('click', () => {
        // Lógica para editar el nombre de usuario
    });
}
if(btnGuardarJugadora){
btnGuardarJugadora.addEventListener('click', async () => {
    const nuevaJugadora = inputField.getAttribute('data-id');
    if (nuevaJugadora) {
        const exito = await updateJugadoraPerfil(nuevaJugadora);
        if (exito) {
            displaySpan.textContent = inputField.value; // Actualizamos el nombre mostrado
            displaySpan.style.display = 'inline';
            btnEditar.style.display = 'inline';
            inputContainer.style.display = 'none';
            location.reload();
        } else {
                alert('Error al actualizar la jugadora favorita. Por favor, inténtalo de nuevo.');
        }
    }
});
}if(btnGuardarEquipo){
btnGuardarEquipo.addEventListener('click', async () => {
    const nuevoEquipo = equopinputField.getAttribute('data-id');
    if (nuevoEquipo) {
        const exito = await updateEquipoPerfil(nuevoEquipo);
        if (exito) {
            displaySpan.textContent = equopinputField.value; // Actualizamos el nombre mostrado
            displaySpan.style.display = 'inline';
            btnEditar.style.display = 'inline';
            inputContainer.style.display = 'none';
            location.reload();
        } else {
                alert('Error al actualizar el equipo favorito. Por favor, inténtalo de nuevo.');
        }
    }
});
}

if (btnEditar) {
    btnEditar.addEventListener('click', () => {
        // Intercambiamos visibilidad
        displaySpan.style.display = 'none';
        btnEditar.style.display = 'none';
        inputContainer.style.display = 'block';
            
        inputField.focus(); // Ponemos el foco automáticamente
    });

    // Listener para el autocompletado
    inputField.addEventListener('input', event => {
        handleAutocompletePlayer(event);
    }); // Debounce de 300ms


    // Opcional: Cerrar si el usuario pulsa Esc o hace click fuera
    inputField.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            displaySpan.style.display = 'inline';
            btnEditar.style.display = 'inline';
            inputContainer.style.display = 'none';
        }
    });
}if (btnEditarEquipo) {
    btnEditarEquipo.addEventListener('click', () => {
        // Intercambiamos visibilidad
        displaySpan.style.display = 'none';
        btnEditarEquipo.style.display = 'none';
        inputContainer.style.display = 'block';
            
        inputField.focus(); // Ponemos el foco automáticamente
    });

    // Listener para el autocompletado
    equopinputField.addEventListener('input', event => {
        handleAutocompletePlayer(event);
    }); // Debounce de 300ms


    // Opcional: Cerrar si el usuario pulsa Esc o hace click fuera
    equopinputField.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            displaySpan.style.display = 'inline';
            btnEditarEquipo.style.display = 'inline';
            inputContainer.style.display = 'none';
        }
    });
}

const rachas = await obtenerRachaPerfil(perfilId);
const rachasDiv = document.getElementById('rachas');

// 1. Creamos la estructura del Slider
rachasDiv.innerHTML = `
    <div class="slider-header">
        <h2>Rachas</h2>
        <div class="slider-controls">
            <button class="nav-btn prev" id="prevBtn"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0"/>
                </svg>
            </button>
            <button class="nav-btn next" id="nextBtn"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>
                </svg>
            </button>
        </div>
    </div>
    <div class="streak-slider-viewport">
        <div class="streak-grid" id="streakTrack"></div>
    </div>
`;

const track = document.getElementById('streakTrack');

// ordenar por mejor_racha
rachas.sort((a, b) => b.mejor_racha - a.mejor_racha);

rachas.forEach((racha, index) => {
    console.log(index)
    const card = document.createElement('div');
    const porcentaje = Math.min((racha.racha_actual / racha.mejor_racha) * 100, 100);
    const foto = racha.juego.slug 
    ? `/static/img/${racha.juego.slug}-logo-fondo.webp` 
    : '/static/img/logo.webp';
    card.classList.add('discord-streak-card');
    if (racha.racha_actual > 5) card.classList.add('on-fire');

    const medalClass = index + 1;

    card.innerHTML = `
        <div class="card-inner d-flex align-items-center justify-content-between p-2">
            <!-- Izquierda: Posición (Medalla) y Avatar con enlace de usuario -->
            <div class="d-flex align-items-center gap-3" id="posicion">
                <div class="text-center fw-bold align-middle rank" style="min-width: 30px;">${medalClass}</div>
                
                <div class="d-flex align-items-center account" style="margin-left: 15px;">
                    <a href="/accounts/perfil/${h1.textContent}/" class="text-decoration-none text-info fw-bold d-flex align-items-center gap-2">
                        <img src="${escudo.src || foto}" 
                            class="avatar rounded-circle" 
                            style="width: 30px; height: 30px; object-fit: cover;">
                        <span>${h1.textContent}</span>
                    </a>
                </div>
            </div>

            <!-- Centro: Detalles del juego y estadísticas de racha -->
            <div class="game-details mx-3 flex-grow-1">
                <div class="game-name text-muted mb-1 small">${racha.juego.nombre}</div>
                <div class="streak-stats d-flex align-items-center gap-2">
                    <span class="current">Racha: <strong>${racha.racha_actual}</strong></span>
                    <div class="progress-container flex-grow-1" style="max-width: 120px;">
                        <div class="progress-bar" style="width: ${porcentaje}%"></div>
                    </div>
                    <span class="separator">•</span>
                    <span class="best">Mejor: ${racha.mejor_racha}</span>
                </div>
            </div>

            <!-- Derecha: Icono de fuego visual -->
            <div class="streak-visual ms-2">
                <i class="fas fa-fire ${racha.racha_actual > 5 ? 'burning' : ''}" style="font-size: 1.5rem;"></i>
            </div>
        </div>
    `;
    track.appendChild(card);
});

// 2. Lógica de Navegación con GSAP
let scrollAmount = 0;
const cardWidth = 312; // Ancho de la card (300px) + gap (12px)

document.getElementById('nextBtn').addEventListener('click', () => {
    const maxScroll = track.scrollWidth - track.parentElement.clientWidth;
    if (scrollAmount < maxScroll) {
        scrollAmount += cardWidth;
        gsap.to(track, { x: -scrollAmount, duration: 0.5, ease: "power2.out" });
    }
});

document.getElementById('prevBtn').addEventListener('click', () => {
    if (scrollAmount > 0) {
        scrollAmount -= cardWidth;
        gsap.to(track, { x: -scrollAmount, duration: 0.5, ease: "power2.out" });
    }
});