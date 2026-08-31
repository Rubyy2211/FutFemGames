const buttons = document.querySelectorAll('.game-button');
const expo = document.getElementById('dynamic-bg');
const hoverSound = new Audio('/static/sounds/hover2.mp3');

// 🟢 OBTENER ELEMENTOS H2 Y GUARDAR TÍTULOS PREDETERMINADOS
const dailyH2 = document.querySelector('#daily-games h2, #diarios h2');
const regularH2 = document.querySelector('#regular-games h2, #regulares h2');

const defaultDailyText = dailyH2 ? dailyH2.textContent : 'Diarios';
const defaultRegularText = regularH2 ? regularH2.textContent : 'Regulares';

// 🎬 FUNCIÓN PARA ANIMAR EL CAMBIO DE TEXTO EN LOS H2
function updateH2Text(h2Element, newText) {
  if (!h2Element || h2Element.textContent === newText) return;

  gsap.killTweensOf(h2Element);

  gsap.to(h2Element, {
    autoAlpha: 0,
    xPercent: -50,
    yPercent: -60, // Sube ligeramente desde el centro (-50%)
    duration: 0.12,
    ease: "power1.in",
    onComplete: () => {
      h2Element.textContent = newText;
      gsap.set(h2Element, { xPercent: -50, yPercent: -40 }); // Inicia un poco más abajo
      gsap.to(h2Element, {
        autoAlpha: 1,
        xPercent: -50,
        yPercent: -50, // Regresa a su posición centrada (-50%, -50%)
        duration: 0.25,
        ease: "back.out(1.5)"
      });
    }
  });
}

// Función auxiliar para restablecer todos los botones a su estado normal
function resetAllGameButtons() {
  buttons.forEach(btn => {
    btn.classList.remove('active');
    gsap.to(btn, { scale: 1, opacity: 1, duration: 0.3 });
  });
}

buttons.forEach(card => {
  card.addEventListener('mouseenter', () => {
    if (card.classList.contains('active')) return;

    // 1. Extraer datos del dataset del botón
    const { bg, titulo } = card.dataset;

    // 2. Cambiar el H2 CON ANIMACIÓN según la sección
    const parentDaily = card.closest('#diarios, #daily-games');
    const parentRegular = card.closest('#regulares, #regular-games');

    if (parentDaily && dailyH2 && titulo) {
      updateH2Text(dailyH2, titulo);
    } else if (parentRegular && regularH2 && titulo) {
      updateH2Text(regularH2, titulo);
    }

    // 3. Cambiar fondo dinámico con GSAP
    if (bg && expo) {
      gsap.to(expo, {
        duration: 0.4,
        autoAlpha: 1,
        backgroundImage: `linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url(${bg})`,
        display: 'flex',
        ease: "power2.out"
      });
    }

    // 4. Reproducir sonido
    if (typeof hoverSound !== 'undefined') {
      hoverSound.currentTime = 0;
      hoverSound.play();
    }

    // 5. GESTIONAR ESTADO ACTIVO DE LOS BOTONES
    const sectionContainer = parentDaily || parentRegular || document;
    const sectionButtons = sectionContainer.querySelectorAll('.game-button');

    sectionButtons.forEach(other => {
      if (other === card) {
        other.classList.add('active');
        gsap.to(other, { scale: 1.05, opacity: 1, duration: 0.3 });
      } else {
        other.classList.remove('active');
        gsap.to(other, { scale: 1, opacity: 0.7, duration: 0.3 });
      }
    });
  });

  card.addEventListener('mouseleave', () => {
    // Se mantiene activo hasta cambiar de botón o de sección
  });
});


// ANIMACION MENÚ PRINCIPAL
const selectorLinks = document.querySelectorAll('#selector a');
const dynamicBg = document.getElementById('dynamic-bg');
const sections = document.querySelectorAll('#diarios, #regulares');

// 1. Definir la sección e ítem inicial por defecto (#diarios)
const initialSection = document.getElementById('diarios');
let currentActiveSection = initialSection;

let currentActiveLink = Array.from(selectorLinks).find(link => {
  const href = link.getAttribute('href');
  return href === '#diarios' || link.querySelector('p')?.textContent.trim().toLowerCase() === 'diarios';
}) || selectorLinks[0];

// 2. Estado inicial de las secciones
sections.forEach(sec => {
  if (sec === initialSection) {
    gsap.set(sec, { autoAlpha: 1, display: 'flex', y: 0 });
    const infos = sec.querySelectorAll('.panel-info');
    gsap.set(infos, { autoAlpha: 1, y: 0 });
  } else {
    gsap.set(sec, { autoAlpha: 0, display: 'none', y: 10 });
    const infos = sec.querySelectorAll('.panel-info');
    gsap.set(infos, { autoAlpha: 0, y: 15 });
  }
});

// 3. Inicializar enlaces y eventos hover del selector
selectorLinks.forEach(link => {
  const isInitialActive = (link === currentActiveLink);

  if (isInitialActive) {
    link.classList.add('active');
    gsap.set(link, {
      "--arrowOpacity": 1,
      "--arrowScale": 1,
      "--arrowYTop": "0px",
      "--arrowYBottom": "0px"
    });

    const initBg = link.dataset.bg;
    if (initBg && dynamicBg) {
      dynamicBg.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('${initBg}')`;
      gsap.set(dynamicBg, { opacity: 1 });
    }
  } else {
    link.classList.remove('active');
    gsap.set(link, {
      "--arrowOpacity": 0,
      "--arrowScale": 1.5,
      "--arrowYTop": "-25px",
      "--arrowYBottom": "25px"
    });
  }

  const href = link.getAttribute('href');
  let targetId = href && href.startsWith('#') ? href : null;
  
  if (!targetId) {
    const text = link.querySelector('p')?.textContent.trim().toLowerCase();
    if (text) targetId = `#${text}`;
  }

  const targetSection = targetId ? document.querySelector(targetId) : null;

  link.addEventListener('mouseenter', () => {
    if (link === currentActiveLink) return;

    if (typeof hoverSound !== 'undefined') {
      hoverSound.currentTime = 0;
      hoverSound.play();
    }

    selectorLinks.forEach(otherLink => {
      gsap.killTweensOf(otherLink);

      if (otherLink === link) {
        otherLink.classList.add('active');
        gsap.to(otherLink, {
          "--arrowOpacity": 1,
          "--arrowScale": 1,
          "--arrowYTop": "0px",
          "--arrowYBottom": "0px",
          duration: 0.3,
          ease: "back.out(1.7)"
        });
      } else {
        otherLink.classList.remove('active');
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

    // 🟢 CAMBIO DE SECCIÓN PANEL (RESTAURAR TÍTULOS CON ANIMACIÓN)
    if (targetSection && targetSection !== currentActiveSection) {
      
      // Restauramos los títulos con la animación suave
      if (dailyH2) updateH2Text(dailyH2, defaultDailyText);
      if (regularH2) updateH2Text(regularH2, defaultRegularText);

      // Restauramos los botones a su estado sin selección
      resetAllGameButtons();

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