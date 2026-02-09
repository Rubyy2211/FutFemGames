let intervalos = {}; // Objeto para almacenar los intervalos

export function inicializarCounter(facil, medio, dificil, juego , dificultad){
        // Definir los segundos según la dificultad
    let segundos;
    switch (dificultad) {
        case "facil":
            segundos = facil;
            break;
        case "medio":
            segundos = medio;
            break;
        case "dificil":
            segundos = dificil;
            break;
        case "infinito":
            segundos = 86400;
        default:
            segundos = localStorage.getItem(juego); // Valor por defecto si la dificultad no es válida
    }

    return segundos;

}

export function startCounter(segundos, juego, onFinish) {
    let reloj = document.getElementById('reloj');

    // Limpiar cualquier intervalo previo asociado a este juego
    if (intervalos[juego]) clearInterval(intervalos[juego]);

    intervalos[juego] = setInterval(() => {
        reloj.textContent = segundos;

        if (segundos <= 0) {
            clearInterval(intervalos[juego]);
            delete intervalos[juego];
            console.log("Tiempo agotado");
            if (onFinish) onFinish();
        } else {
            localStorage.setItem(juego, segundos);
            segundos--;
           //console.log(segundos);
        }
    }, 1000);
}

export function stopCounter(juego) {
    if (intervalos[juego]) {
        clearInterval(intervalos[juego]); // Detiene el intervalo
        delete intervalos[juego]; // Elimina la referencia
        console.log(`Contador de ${juego} detenido`);
    } else {
        console.log(`No hay un contador en ejecución para ${juego}`);
    }
}