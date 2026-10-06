export function ajustarAlturaSugerencias(input, suggestionsList) {

    if (!input || !suggestionsList) {
        return;
    }

    const rect = input.getBoundingClientRect();

    const espacioAbajo =
        window.innerHeight - rect.bottom - 10;

    const espacioArriba =
        rect.top - 10;

    const alturaMaxima = 300;

    // Si no hay suficiente espacio abajo,
    // mostramos las sugerencias hacia arriba
    if (espacioAbajo < 200 && espacioArriba > espacioAbajo) {

        suggestionsList.style.bottom = 'auto';
        suggestionsList.style.top = 'calc(100% + 6px)';

        suggestionsList.style.maxHeight =
            `${Math.min(alturaMaxima, espacioArriba)}px`;

    } else {

        suggestionsList.style.bottom = 'auto';
        suggestionsList.style.top = 'calc(100% + 6px)';

        suggestionsList.style.maxHeight =
            `${Math.min(alturaMaxima, espacioAbajo)}px`;
    }
}