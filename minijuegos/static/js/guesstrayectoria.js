let jugadoraId;
let nombreCompleto;
// Función principal que controla el flujo de carga

async function iniciar(dificultad) {
    const popup = document.getElementById('popup-ex'); // Selecciona el primer elemento con la clase 'popup-ex'
    const answer = localStorage.getItem('Attr1');
    const name = await sacarJugadora(jugadoraId);
    if (popup) {
    popup.style.display = 'none'; // Cambia el estilo para ocultarlo
    }
    let jugadora = await fetchData(1);
    jugadoraId = jugadora.idJugadora.toString(); // Convertir a string para comparación segura
    localStorage.setItem('res1', jugadoraId);

    console.log(jugadora.idJugadora);

    // Definir los segundos según la dificultad
    let segundos;
    switch (dificultad) {
        case "facil":
            segundos = 100090;
            break;
        case "medio":
            segundos = 60;
            break;
        case "dificil":
            segundos = 30;
            break;
        default:
            segundos = localStorage.getItem('trayectoria'); // Valor por defecto si la dificultad no es válida
    }

    // Obtener valores de localStorage
    const nombre = localStorage.getItem('nombre');

    // Verificar si el usuario ha ganado
    const isAnswerTrue = (answer === jugadoraId);
    console.log('Has won:', isAnswerTrue);

    if (isAnswerTrue) {
        console.log("Deteniendo contador..."); // Verificar si llega aquí
        await loadJugadoraById(jugadoraId, true);
        stopCounter("trayectoria");  // ⬅️ Detenemos el temporizador si el usuario gana
        Ganaste('trayectoria');
        document.getElementById('result').textContent = name[0].Nombre_Completo;
    } else {
        await loadJugadoraById(jugadoraId, false);

        if (!answer || answer.trim() === '') {
            startCounter(segundos, "trayectoria", async () => {
                console.log("El contador llegó a 0. Ejecutando acción...");
                await trayectoriaPerder();
            });
        } else if (answer === 'loss') {
            await trayectoriaPerder();
        } else {
            startCounter(segundos, "trayectoria", async () => {
                console.log("El contador llegó a 0. Ejecutando acción...");
                await trayectoriaPerder();
            });
        }
    }
}

async function loadJugadoraById(id, ganaste) {
    try {
        const response = await fetch(`/api/jugadora_trayectoria?id=${id}`);
        if (!response.ok) {
            throw new Error(`Error en la solicitud: ${response.statusText}`);
        }

        const data = await response.json();
        console.log('Datos recibidos:', data);

        if (Array.isArray(data) && data.length > 0) {
            displayTrayectoria(data, ganaste);
        } else {
            console.warn('No hay datos de la jugadora disponibles.');
        }
    } catch (error) {
        console.error('Error al cargar la jugadora:', error);
        document.getElementById('result').textContent = 'Error al cargar los datos.';
    }
}

function displayTrayectoria(data, acertaste) {
    const trayectoriaDiv = document.getElementById('trayectoria');
    trayectoriaDiv.setAttribute('Attr1', data[0].jugadora)
    trayectoriaDiv.innerHTML = ''; // Limpiar contenido previo
    const myst = document.getElementById('jugadora');

    const maxPerRow = 5;
    let currentRow;

    data.forEach((item, index) => {
        if (index % maxPerRow === 0) {
            currentRow = document.createElement('div');
            currentRow.classList.add('trayectoria-row');
            trayectoriaDiv.appendChild(currentRow);
        }

        const flipContainer = document.createElement('div');
        flipContainer.classList.add('flip-container');

        const flipper = document.createElement('div');
        flipper.classList.add('flipper');

        // Lado frontal
        const front = document.createElement('div');
        front.classList.add('front');

        if (item.escudo) {
            const escudoImg = document.createElement('img');
            escudoImg.src = item.escudo;
            escudoImg.alt = item.nombre;
            front.appendChild(escudoImg);

            const anyos = document.createElement('p');
            anyos.textContent = item.años;
            anyos.style.textAlign = 'center';
            front.appendChild(anyos);
        }

        flipper.appendChild(front);

        // Solo mostrar la parte trasera si el usuario ha ganado
        if (acertaste) {
            if (data.length > 0) {
                myst.src = data[0].ImagenJugadora; // Asignar imagen de jugadora
            }
            const back = document.createElement('div');
            back.classList.add('back');

            if (item.imagen) {
                const jugadoraImg = document.createElement('img');
                jugadoraImg.src = item.imagen;
                jugadoraImg.alt = 'Imagen de la Jugadora';
                back.appendChild(jugadoraImg);

                const anyos = document.createElement('p');
                anyos.textContent = item.años;
                anyos.style.textAlign = 'center';
                back.appendChild(anyos);

                flipper.appendChild(back);
            }
        }

        flipContainer.appendChild(flipper);
        currentRow.appendChild(flipContainer);
    });
}

async function checkAnswer() {
    const textoInput = document.getElementById('jugadoraInput');
    const nombreCompleto = textoInput.value.trim();
    const idJugadora = textoInput.getAttribute('data-id');
    const div = document.getElementById('trayectoria');
    const result = document.getElementById('result');

    if (!idJugadora) {
        console.warn('No se encontró data-id en el input.');
        return;
    }else if(div.getAttribute('Attr1')===idJugadora){
        if(!localStorage.getItem('Attr1')){
            await updateRacha(1, 2);
        }else{
            //await updateRacha(1, 1);
    }
        result.textContent = nombreCompleto;
        localStorage.setItem('Attr1', idJugadora);
        localStorage.setItem('nombre', nombreCompleto);

        await loadJugadoraById(idJugadora, true);
        stopCounter('trayectoria');
        Ganaste('trayectoria');
    }else{
        result.textContent = 'Sigue intentando!'
    }
}

async function trayectoriaPerder() {
    // Bloquear el botón y el input
    const boton = document.getElementById('botonVerificar');
    const input = document.getElementById('jugadoraInput');
    const resultDiv = document.getElementById('result');
    const jugadora = await sacarJugadora(jugadoraId);

    boton.disabled = true;
    input.disabled = true;

    resultDiv.textContent = 'Has perdido, era: '+jugadora[0].Nombre_Completo;
    const div = document.getElementById('trayectoria');
    const jugadora_id = 'loss';
    localStorage.setItem('Attr1', jugadora_id);
    await loadJugadoraById(jugadoraId, true);
    // Agregar un delay de 2 segundos (2000 ms)
    if(localStorage.length>0){
        await updateRacha(1, 0);
    }
    setTimeout(() => {
        cambiarImagenConFlip();
    }, 1000);
}

const texto = 'Adivina la Jugadora de Fútbol es un juego de trivia donde debes identificar a una futbolista según los equipos en los que ha jugado. Usa las pistas, demuestra tu conocimiento y compite para ver quién acierta más.';
const imagen = '../img/trayectoria.jpg';
play().then(r => r);
async function play() {
    let jugadora = await fetchData(1);
    console.log(jugadora)
    jugadoraId = jugadora.idJugadora.toString(); // Convertir a string para comparación segura
    const res = localStorage.getItem('res1');
    if(res !== jugadoraId || !res){
        localStorage.removeItem('Attr1');
        crearPopupInicialJuego('Guess Trayectoria', texto, imagen);
    } else {
        await iniciar('');
    }
}
