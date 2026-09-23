// Variables de Juego
let jugadoraId;
let nombreCompleto;
let ultimaRespuesta;

// Componentes html usados recurrentemente
let popup, resultText, trayectoriaDiv, myst, jugadoraInput, boton, answer, textoInput;

// Función principal que controla el flujo de carga
async function iniciar(dificultad) {
    const {Ganaste} = await import("/static/js/games/funciones-comunes.js");
    const {inicializarCounter, startCounter, stopCounter } = await import('/static/js/utils/counter.js');
    const {handleAutocompletePlayer} = await import("/static/futfem/js/jugadora.js");
    popup = document.getElementById('popup-ex');
    resultText =  document.getElementById('result');
    trayectoriaDiv = document.getElementById('trayectoria');
    myst = document.getElementById('jugadora');
    jugadoraInput = document.getElementById('jugadoraInput');
    boton = document.getElementById('botonVerificar');
    textoInput = document.getElementById("jugadoraInput");
    textoInput.addEventListener('input', debounce(handleAutocompletePlayer, 300)); // Debounce de 300ms
    const name = localStorage.getItem('nombre');
    
    if (boton) {
        boton.addEventListener('click', checkAnswer); // Habilitar el botón al iniciar el juego
    }
    
    if (popup) {
        popup.style.display = 'none'; // Cambia el estilo para ocultarlo
    }
    
    let jugadora = await fetchData(1);
    jugadoraId = jugadora.idJugadora.toString(); // Convertir a string para comparación segura
    localStorage.setItem('res1', jugadoraId);
    console.log('Jugadora ID asignada:', localStorage.getItem('res1'), ultimaRespuesta);

    if(ultimaRespuesta === jugadoraId){
        console.log('Se ha guardado la respuesta'); 
        localStorage.setItem('Attr1', ultimaRespuesta);
    }

    if(ultimaRespuesta === 'loss'+jugadoraId){
        console.log('Se ha guardado la perdida'); 
        localStorage.setItem('Attr1', 'loss'+jugadoraId);
    }

    // Definir los segundos según la dificultad
    let segundos = inicializarCounter(120000000000000000000000000000000000000000000000000000000000000000, 60, 30, 'trayectoria', dificultad);

    // Verificar si el usuario ha ganado
    answer = localStorage.getItem('Attr1');
    const isAnswerTrue = (answer === jugadoraId);
    console.log('Has won:', isAnswerTrue);

    if (isAnswerTrue) {
        console.log("Deteniendo contador..."); // Verificar si llega aquí
        await loadJugadoraById(jugadoraId, true);
        stopCounter("trayectoria");  // ⬅️ Detenemos el temporizador si el usuario gana
        Ganaste('trayectoria');
        resultText.textContent = name;
    } else {
        await loadJugadoraById(jugadoraId, false);

        if (!answer || answer.trim() === '') {
            startCounter(segundos, "trayectoria", async () => {
                console.log("El contador llegó a 0. Ejecutando acción...");
                await trayectoriaPerder();
            });
        } else if (answer === 'loss'+jugadoraId) {
            await trayectoriaPerder();
        } else {
            startCounter(segundos, "trayectoria", async () => {
                console.log("El contador llegó a 0. Ejecutando acción...");
                await trayectoriaPerder();
            });
        }
    }
}

play().then(r => r);
async function play() {
    const {obtenerUltimaRespuesta} = await import("/static/usuarios/js/rachas.js");
    ultimaRespuesta = await obtenerUltimaRespuesta(1);
    const lastAnswer= localStorage.getItem('Attr1');
    let jugadora = await fetchData(1);
    jugadoraId = jugadora.idJugadora.toString(); // Convertir a string para comparación segura
    const res = localStorage.getItem('res1');
    console.log('Jugadora ID asignada:', jugadoraId, ultimaRespuesta, res);
    const texto = gettext('Adivina la Jugadora de Fútbol es un juego de trivia donde debes identificar a una futbolista según los equipos en los que ha jugado. Usa las pistas, demuestra tu conocimiento y compite para ver quién acierta más.');
    const imagen = '/static/img/trayectoria.png';
    const {crearPopupInicialJuego} = await import("/static/js/games/funciones-comunes.js");
    if(ultimaRespuesta && ultimaRespuesta === jugadoraId){       
        await iniciar('');
    }else if(res !== jugadoraId || !res){
        /*if(lastAnswer !== res || !lastAnswer){
            updateRacha(1, 0, 'loss'+jugadoraId);
        }*/
        localStorage.removeItem('Attr1');
        crearPopupInicialJuego(gettext('Futfem Career'), texto, imagen, '', iniciar);
    } else {       
        await iniciar('');
    }
}

export async function loadJugadoraById(id, ganaste) {
    const { fetchJugadoraTrayectoriaById } = await import("/static/futfem/js/jugadora.js");
    const data = await fetchJugadoraTrayectoriaById(id);
    if (data.length > 0) {
        displayTrayectoria(data, ganaste);
    } else {
        console.warn('No se encontraron datos de trayectoria para la jugadora con ID:', id);
    }
}

function displayTrayectoria(data, acertaste) {
    console.log('Datos de trayectoria recibidos:', data);
    // 1. Comprobar si el último registro de la jugadora es el equipo 83
    const ultimoRegistro = data.length > 0 ? data[data.length - 1] : null;
    const esEquipoActual83 = ultimoRegistro && ultimoRegistro.equipo === 83;
    console.log(esEquipoActual83 ? 'El último equipo es el 83' : 'El último equipo no es el 83');
    // 2. Filtrar equipos válidos (excluyendo equipo 83) para renderizar las tarjetas
    const equiposValidos = data.filter(item => item.equipo !== 83);

    trayectoriaDiv.setAttribute('Attr1', data[0]?.jugadora || '');
    trayectoriaDiv.style.setProperty('--num-equipos', equiposValidos.length);
    trayectoriaDiv.innerHTML = ''; // Limpiar contenido previo

    // Contenedor único para mantener todos los escudos en una sola fila
    const row = document.createElement('div');
    row.classList.add('trayectoria-row');
    trayectoriaDiv.appendChild(row);

    equiposValidos.forEach((item, index) => {
        const isFirst = index === 0;
        const isLast = index === equiposValidos.length - 1;

        const flipContainer = document.createElement('div');
        flipContainer.classList.add('flip-container');

        const flipper = document.createElement('div');
        flipper.classList.add('flipper');

        // Lado frontal (Front)
        const front = document.createElement('div');
        front.classList.add('front');

        if (item.escudo) {
            const escudoImg = document.createElement('img');
            escudoImg.src = item.escudo;
            escudoImg.alt = item.nombre;
            escudoImg.classList.add('glass');
            escudoImg.style.background = `
                linear-gradient(
                    to bottom,
                    color-mix(in srgb, ${item.color} 80%, transparent),
                    color-mix(in srgb, var(--color-secundario) 80%, transparent)
                )
            `;
            escudoImg.style.borderColor = item.color;
            front.appendChild(escudoImg);
        } else {
            const escudoImg = document.createElement('img');
            escudoImg.alt = item.nombre;
            front.appendChild(escudoImg);
        }

        // Fechas en la parte frontal
        /*const fechasDivFront = crearContenedorFechas(item.fecha_inicio, item.fecha_fin, isFirst, isLast);
        if (fechasDivFront) front.appendChild(fechasDivFront);*/

        flipper.appendChild(front);

        // Lado trasero (Back): SOLO si acertó Y el último equipo de la jugadora es el 83
        if (acertaste) { 
            if (data.length > 0 && typeof myst !== 'undefined') {
                myst.src = data[0].ImagenJugadora || '/static/img/predeterm.png';
            }
        }
        if (acertaste && esEquipoActual83) {
            const back = document.createElement('div');
            back.classList.add('back');

            const jugadoraImg = document.createElement('img');
            jugadoraImg.src = item.imagen ? item.imagen : item.escudo;
            jugadoraImg.alt = 'Imagen de la Jugadora';
            jugadoraImg.className = 'glass';
            jugadoraImg.style.borderColor = item.color;
            back.appendChild(jugadoraImg);

            // Fechas en la parte trasera
            /*const fechasDivBack = crearContenedorFechas(item.fecha_inicio, item.fecha_fin, isFirst, isLast);
            if (fechasDivBack) back.appendChild(fechasDivBack);*/

            flipper.appendChild(back);
        }

        flipContainer.appendChild(flipper);
        row.appendChild(flipContainer);
    });
}

function crearContenedorFechas(fechaInicio, fechaFin, isFirst, isLast) {
    // Si no es ni el primero ni el último, no mostramos nada
    if (!isFirst && !isLast) return null;

    const contenedor = document.createElement('div');
    contenedor.classList.add('fechas-container');

    // 1. Caso: Único equipo en la trayectoria (es primero Y último)
    if (isFirst && isLast) {
        const spanInicio = document.createElement('span');
        spanInicio.classList.add('fecha-inicio');
        spanInicio.textContent = fechaInicio ? fechaInicio.substring(0, 4) : '';

        const spanGuion = document.createElement('span');
        spanGuion.classList.add('fecha-guion');
        spanGuion.textContent = '-';

        const spanFin = document.createElement('span');
        spanFin.classList.add('fecha-fin');
        spanFin.textContent = fechaFin ? fechaFin.substring(0, 4) : 'Act.';

        contenedor.appendChild(spanInicio);
        contenedor.appendChild(spanGuion);
        contenedor.appendChild(spanFin);

        return contenedor;
    }

    // 2. Caso: Primer equipo -> Solo fecha de inicio
    if (isFirst && fechaInicio) {
        const spanGuion = document.createElement('span');
        const spanInicio = document.createElement('span');
        spanInicio.classList.add('fecha-inicio');
        spanInicio.textContent = fechaInicio.substring(0, 4);
        spanGuion.textContent = "-"
        const spanFin = document.createElement('span');
        spanFin.classList.add('fecha-fin');
        spanFin.textContent = fechaFin ? fechaFin.substring(0, 4) : 'Act.';
        contenedor.appendChild(spanInicio);
        contenedor.appendChild(spanGuion);
        contenedor.appendChild(spanFin);
    }

    // 3. Caso: Último equipo -> Solo fecha de fin (o 'Act.')
    if (isLast) {
        const spanGuion = document.createElement('span');
        const spanInicio = document.createElement('span');
        spanInicio.classList.add('fecha-inicio');
        spanInicio.textContent = fechaInicio.substring(0, 4);
        spanGuion.textContent = "-"
        const spanFin = document.createElement('span');
        spanFin.classList.add('fecha-fin');
        spanFin.textContent = fechaFin ? fechaFin.substring(0, 4) : 'Act.';
        contenedor.appendChild(spanInicio);
        contenedor.appendChild(spanGuion);
        contenedor.appendChild(spanFin);
    }

    return contenedor;
}

async function checkAnswer() {
    const nombreCompleto = jugadoraInput.value.trim();
    const idJugadora = jugadoraInput.getAttribute('data-id');
    const {wrong, victory} = await import("/static/js/sounds.js");
    const {updateRacha} = await import("/static/usuarios/js/rachas.js");
    const {Ganaste} = await import("/static/js/games/funciones-comunes.js");
    const {stopCounter} = await import('/static/js/utils/counter.js');

    if (!idJugadora) {
        console.warn('No se encontró data-id en el input.');
        return;
    }else if(trayectoriaDiv.getAttribute('Attr1')===idJugadora){
        if(!localStorage.getItem('Attr1')){
            console.log('Actualizando racha con última respuesta:', idJugadora);
            await updateRacha(1, 1, idJugadora);
            victory.play()
        }else{
            //await updateRacha(1, 1, idJugadora);
    }
        resultText.textContent = nombreCompleto;
        localStorage.setItem('Attr1', idJugadora);
        localStorage.setItem('nombre', nombreCompleto);

        await loadJugadoraById(idJugadora, true);
        stopCounter('trayectoria');
        Ganaste('trayectoria');
    }else{
        wrong.play()
        resultText.textContent = gettext('Sigue intentando!');
    }
}

async function trayectoriaPerder() {
    // Bloquear el botón y el input
    const jugadora = await sacarJugadora(jugadoraId);
    const {updateRacha} = await import("/static/usuarios/js/rachas.js");

    boton.disabled = true;
    jugadoraInput.disabled = true;

    //resultText.textContent = 'Has perdido, era: '+jugadora[0].Nombre_Completo;
    const jugadora_id = 'loss';
    localStorage.setItem('Attr1', jugadora_id);
    await loadJugadoraById(jugadoraId, true);
    // Agregar un delay de 2 segundos (2000 ms)
    if(localStorage.length>0){
        await updateRacha(1, 0, 'loss'+jugadoraId);
    }
    setTimeout(() => {
        cambiarImagenConFlip();
    }, 1000);
}