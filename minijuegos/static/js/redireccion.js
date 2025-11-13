// redirect.js

function redireccionarA(url) {
    // Redirige a la página de carga primero
    window.location.href = 'loading?url=' + encodeURIComponent(url);
}

// Al cargar la página, redirige a la página final especificada en la URL
document.addEventListener('DOMContentLoaded', function() {
    var urlParams = new URLSearchParams(window.location.search);
    var finalUrl = urlParams.get('url');
    if (finalUrl) {
        // Redirige a la página final después de 2 segundos
        setTimeout(function() {
            window.location.href = finalUrl;
        }, 2000); // Retraso de 2 segundos
    } else {
        //console.error('No se especificó la URL final.');
    }
});
