/*const buttons = document.querySelectorAll('.game-button');
const expo = document.getElementById('juego-expo');
const expoTitulo = document.getElementById('juego-titulo');
const expoParrafo = document.getElementById('juego-parrafo');
const expoImagen = document.getElementById('juego-imagen');
const webButtons = document.querySelectorAll('.web-button');*/
const hoverSound = new Audio('/static/sounds/hover2.mp3');

/*webButtons.forEach(card => {
  // Buscamos la imagen dentro de la etiqueta picture de ESTE botón web
  const innerImg = card.querySelector('picture img');

  // ENTRAR: Suena el audio y escalamos la imagen interna con GSAP
  card.addEventListener('mouseenter', () => {
    hoverSound.currentTime = 0;
    hoverSound.play();

    if (innerImg) {
      gsap.to(innerImg, { 
        scale: 1.05,        // Cambia este valor si quieres que se estire más o menos
        duration: 0.4, 
        ease: "power2.out" 
      });
    }
  });

  // SALIR: Restauramos la imagen a su tamaño original (scale: 1)
  card.addEventListener('mouseleave', () => {
    if (innerImg) {
      gsap.to(innerImg, { 
        scale: 1, 
        duration: 0.3, 
        ease: "power2.out" 
      });
    }
  });
});

buttons.forEach(card => {
  card.addEventListener('mouseenter', () => {
    // 1. Extraer datos del dataset del botón
    const { bg, titulo, descripcion, img } = card.dataset;

    // 2. Actualizar contenido de la expo
    expoTitulo.textContent = titulo;
    expoParrafo.textContent = descripcion;
    expoImagen.src = img;

    // 3. Cambiar fondo y mostrar contenedor con GSAP
    gsap.to(expo, {
      duration: 0.4,
      autoAlpha: 1, // Esto maneja visibility y opacity a la vez
      backgroundImage: `linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url(${bg})`,
      display: 'flex', // Asegura que se vea si estaba en none
      ease: "power2.out"
    });

    // --- Tu lógica previa de hoverSound y opacidad de otros botones ---
    hoverSound.currentTime = 0;
    hoverSound.play();

    buttons.forEach(other => {
      if (other !== card) gsap.to(other, { opacity: 1, duration: 0.3 });
    });
    gsap.to(card, { scale: 1.05, duration: 0.3 });
  });

  card.addEventListener('mouseleave', () => {
    // Opcional: Ocultar la expo al salir del botón o dejar la última seleccionada
    // Si quieres que desaparezca:
    /*
    gsap.to(expoContainer, { autoAlpha: 0, duration: 0.3 });
    */

    // Restaurar botones
    //gsap.to(card, { scale: 1, duration: 0.3 });
    //buttons.forEach(other => {
    //  gsap.to(other, { opacity: 1, duration: 0.3 });
    //});
  //});
//});

// 1. ANIMACIÓN DE ENTRADA (Zoom Out de llegada)
// Función para ejecutar la animación de entrada (Zoom Out)
function animateIn() {
  gsap.fromTo('#container-index', 
    { scale: 1.3, opacity: 0 }, // Estado inicial
    { scale: 1, opacity: 1, duration: 0.5, ease: 'power2.out' } // Estado final
  );
}

// 1. ANIMACIÓN DE ENTRADA (Carga inicial y Navegación Atrás/Adelante)
window.addEventListener('pageshow', (event) => {
  // event.persisted es true si la página se recuperó desde el BFCache (botón Atrás)
  if (event.persisted) {
    animateIn();
  }
});

document.addEventListener('DOMContentLoaded', () => {
  animateIn();
});

// 2. ANIMACIÓN DE SALIDA (Zoom In al hacer clic)
document.querySelectorAll('a').forEach(link => {
  link.addEventListener('click', (e) => {
    const href = link.getAttribute('href');

    // Ignorar anclas (#), enlaces externos en pestaña nueva y javascript:
    if (href && !href.startsWith('#') && !href.startsWith('javascript:') && link.target !== '_blank') {
      e.preventDefault();

      gsap.to('#container-index', {
        scale: 1.5,
        opacity: 0,
        duration: 0.4,
        ease: 'power2.in',
        onComplete: () => {
          window.location.href = href;
        }
      });
    }
  });
});


// ANIMACION MENÚ PRINCIPAL
const selectorLinks = document.querySelectorAll('#selector a');
const dynamicBg = document.getElementById('dynamic-bg');
const defaultSection = document.getElementById('default');
const hoverSections = document.querySelectorAll('#juegos, #wiki, #online, #nosotros');

// Variables para rastrear el estado activo
let currentActiveSection = defaultSection;
let currentActiveLink = null;

// 1. Estado inicial de secciones y sus .panel-info
gsap.set(hoverSections, { autoAlpha: 0, display: 'none', y: 10 });

hoverSections.forEach(sec => {
  const infos = sec.querySelectorAll('.panel-info');
  gsap.set(infos, { autoAlpha: 0, y: 15 });
});

if (defaultSection) {
  gsap.set(defaultSection, { autoAlpha: 1, display: 'flex', y: 0 });
  const defaultInfos = defaultSection.querySelectorAll('.panel-info');
  gsap.set(defaultInfos, { autoAlpha: 1, y: 0 });
}

selectorLinks.forEach(link => {
  // Inicializar variables CSS de las esquinas neón
  gsap.set(link, {
    "--arrowOpacity": 0,
    "--arrowScale": 1.5,
    "--arrowYTop": "-25px",
    "--arrowYBottom": "25px"
  });

  const href = link.getAttribute('href');
  let targetId = href && href.startsWith('#') ? href : null;
  
  if (!targetId) {
    const text = link.querySelector('p')?.textContent.trim().toLowerCase();
    if (text) targetId = `#${text}`;
  }

  const targetSection = targetId ? document.querySelector(targetId) : null;

  link.addEventListener('mouseenter', () => {
    // Sonido hover
    if (typeof hoverSound !== 'undefined') {
      hoverSound.currentTime = 0;
      hoverSound.play();
    }

    // 🟢 1. GESTIÓN DE CLASE ACTIVE Y ESQUINAS NEÓN
    selectorLinks.forEach(otherLink => {
      gsap.killTweensOf(otherLink); // Detiene animaciones en curso

      if (otherLink === link) {
        // Añadir clase active al botón actual
        otherLink.classList.add('active');

        // Encender únicamente el botón activo con GSAP
        gsap.to(otherLink, {
          "--arrowOpacity": 1,
          "--arrowScale": 1,
          "--arrowYTop": "0px",
          "--arrowYBottom": "0px",
          duration: 0.3,
          ease: "back.out(1.7)"
        });
      } else {
        // Quitar clase active a los demás
        otherLink.classList.remove('active');

        // Apagar todos los demás
        gsap.to(otherLink, {
          "--arrowOpacity": 0,
          "--arrowScale": 1.5,
          "--arrowYTop": "-25px",
          "--arrowYBottom": "25px",
          duration: 0.2,
          ease: "power2.in"
        });
      }
    });

    currentActiveLink = link;

    // 2. CAMBIO DE FONDO DINÁMICO
    const newBg = link.dataset.bg;
    if (newBg && dynamicBg) {
      gsap.killTweensOf(dynamicBg);
      gsap.to(dynamicBg, {
        opacity: 0,
        duration: 0.15,
        ease: "power1.in",
        onComplete: () => {
          dynamicBg.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('${newBg}')`;
          gsap.to(dynamicBg, { opacity: 1, duration: 0.35, ease: "power2.out" });
        }
      });
    }

    // 3. CAMBIO DE SECCIÓN PANEL
    if (targetSection && targetSection !== currentActiveSection) {
      if (currentActiveSection) {
        gsap.killTweensOf(currentActiveSection);
        gsap.to(currentActiveSection, { 
          autoAlpha: 0, 
          display: 'none', 
          y: -10, 
          duration: 0.15 
        });
      }

      gsap.killTweensOf(targetSection);
      gsap.set(targetSection, { y: 15 });
      gsap.to(targetSection, {
        duration: 0.35,
        autoAlpha: 1,
        display: 'flex',
        y: 0,
        delay: 0.1,
        ease: "power2.out"
      });

      currentActiveSection = targetSection;
    }
  });
});