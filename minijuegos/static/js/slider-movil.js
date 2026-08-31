const buttons = document.querySelectorAll('.game-button');
const expo = document.getElementById('dynamic-bg');
const hoverSound = new Audio('/static/sounds/hover2.mp3');

// Variable global para controlar si el usuario está arrastrando en PC
let isGlobalDragging = false;

// 🟢 OBTENER ELEMENTOS H2 Y GUARDAR TÍTULOS PREDETERMINADOS
const dailyH2 = document.querySelector('#daily-games h2, #diarios h2');
const regularH2 = document.querySelector('#regular-games h2, #regulares h2');

const defaultDailyText = dailyH2 ? dailyH2.textContent : 'Diarios';
const defaultRegularText = regularH2 ? regularH2.textContent : 'Regulares';

// 🎬 FUNCIÓN PARA ANIMAR EL CAMBIO DE TEXTO (CENTRADOS CON -50%, -50%)
function updateH2Text(h2Element, newText) {
  if (!h2Element || h2Element.textContent === newText) return;

  gsap.killTweensOf(h2Element);

  gsap.to(h2Element, {
    autoAlpha: 0,
    xPercent: -50,
    yPercent: -60,
    duration: 0.12,
    ease: "power1.in",
    onComplete: () => {
      h2Element.textContent = newText;
      gsap.set(h2Element, { xPercent: -50, yPercent: -40 });
      gsap.to(h2Element, {
        autoAlpha: 1,
        xPercent: -50,
        yPercent: -50,
        duration: 0.25,
        ease: "back.out(1.5)"
      });
    }
  });
}

// 🟢 FUNCIÓN PRINCIPAL PARA ACTIVAR UN JUEGO
function activateGameButton(card, shouldScroll = true) {
  if (!card || card.classList.contains('active')) return;

  const { bg, titulo } = card.dataset;

  const parentDaily = card.closest('#diarios, #daily-games');
  const parentRegular = card.closest('#regulares, #regular-games');

  // 1. Centrar automáticamente en pantalla en móvil
  if (window.innerWidth < 768 && shouldScroll) {
    card.scrollIntoView({ behavior: 'smooth', inline: 'center', block: 'nearest' });
  }

  // 2. Cambiar título con animación
  if (parentDaily && dailyH2 && titulo) {
    updateH2Text(dailyH2, titulo);
  } else if (parentRegular && regularH2 && titulo) {
    updateH2Text(regularH2, titulo);
  }

  // 3. Cambiar imagen de fondo
  if (bg && expo) {
    gsap.to(expo, {
      duration: 0.4,
      autoAlpha: 1,
      backgroundImage: `linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url(${bg})`,
      display: 'flex',
      ease: "power2.out"
    });
  }

  // 4. Sonido
  if (typeof hoverSound !== 'undefined') {
    hoverSound.currentTime = 0;
    hoverSound.play();
  }

  // 5. Cambiar estado activo
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
}

// Resetea todos los botones al estado por defecto
function resetAllGameButtons() {
  buttons.forEach(btn => {
    btn.classList.remove('active');
    gsap.to(btn, { scale: 1, opacity: 1, duration: 0.3 });
  });
}

// 🎮 EVENTOS PARA BOTONES DE JUEGOS
buttons.forEach(card => {
  // En Escritorio (Hover): Solo activa si no se está arrastrando el scroll
  card.addEventListener('mouseenter', () => {
    if (window.innerWidth >= 768 && !isGlobalDragging) {
      activateGameButton(card);
    }
  });

  // En Móvil (Click/Tap activa y centra con animación)
  card.addEventListener('click', () => {
    if (window.innerWidth < 768) {
      activateGameButton(card, true);
    }
  });
});

// 📱 DETECTOR DE SCROLL EN MÓVIL
const rows = document.querySelectorAll('#daily-games .row, #regular-games .row');

rows.forEach(row => {
  let isScrolling = false;

  row.addEventListener('scroll', () => {
    if (window.innerWidth >= 768) return; // Desactivar en PC

    if (!isScrolling) {
      window.requestAnimationFrame(() => {
        const rowRect = row.getBoundingClientRect();
        const screenCenter = rowRect.left + rowRect.width / 2;

        let closestCard = null;
        let minDistance = Infinity;

        const cards = row.querySelectorAll('.game-button');
        cards.forEach(card => {
          const cardRect = card.getBoundingClientRect();
          const cardCenter = cardRect.left + cardRect.width / 2;
          const distance = Math.abs(screenCenter - cardCenter);

          if (distance < minDistance) {
            minDistance = distance;
            closestCard = card;
          }
        });

        if (closestCard) {
          activateGameButton(closestCard, false);
        }

        isScrolling = false;
      });
      isScrolling = true;
    }
  });
});

// 🧭 ANIMACIÓN MENÚ PRINCIPAL LATERAL (#selector)
const selectorLinks = document.querySelectorAll('#selector a');
const dynamicBg = document.getElementById('dynamic-bg');
const sections = document.querySelectorAll('#diarios, #regulares');

const initialSection = document.getElementById('diarios');
let currentActiveSection = initialSection;

let currentActiveLink = Array.from(selectorLinks).find(link => {
  const href = link.getAttribute('href');
  return href === '#diarios' || link.querySelector('p')?.textContent.trim().toLowerCase() === 'diarios';
}) || selectorLinks[0];

// Estado inicial de las secciones
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

    // CAMBIO DE SECCIÓN
    if (targetSection && targetSection !== currentActiveSection) {
      if (dailyH2) updateH2Text(dailyH2, defaultDailyText);
      if (regularH2) updateH2Text(regularH2, defaultRegularText);

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
        ease: "power2.out",
        onComplete: () => {
          if (window.innerWidth < 768) {
            const firstCard = targetSection.querySelector('.game-button');
            if (firstCard) {
              activateGameButton(firstCard, true);
            }
          }
        }
      });

      currentActiveSection = targetSection;
    }
  });
});

// 🚀 ACTIVACIÓN INICIAL AL CARGAR LA PÁGINA (MÓVIL)
if (window.innerWidth < 768) {
  const initialCard = initialSection?.querySelector('.game-button');
  if (initialCard) {
    setTimeout(() => {
      activateGameButton(initialCard, true);
    }, 100);
  }
}

// 🖱️ LÓGICA DE SCROLL POR ARRASTRE (DRAG & GRAB) EN PC
const dragRows = document.querySelectorAll('#daily-games .row, #regular-games .row');

dragRows.forEach(row => {
  let isMouseDown = false;
  let startX = 0;
  let scrollLeftPos = 0;
  let hasDragged = false;

  row.addEventListener('mousedown', (e) => {
    if (window.innerWidth < 768 || e.button !== 0) return; // Solo clic izquierdo en PC
    
    isMouseDown = true;
    hasDragged = false;
    isGlobalDragging = false;

    row.classList.add('is-dragging');
    
    startX = e.pageX - row.offsetLeft;
    scrollLeftPos = row.scrollLeft;
  });

  const stopDragging = () => {
    if (!isMouseDown) return;
    isMouseDown = false;
    row.classList.remove('is-dragging');
    
    // Pequeño retardo para evitar activar hover inmediatamente al soltar
    setTimeout(() => {
      isGlobalDragging = false;
    }, 50);
  };

  row.addEventListener('mouseleave', stopDragging);
  window.addEventListener('mouseup', stopDragging);

  row.addEventListener('mousemove', (e) => {
    if (!isMouseDown || window.innerWidth < 768) return;
    
    const x = e.pageX - row.offsetLeft;
    const walk = (x - startX) * 1.5; // Multiplicador de velocidad de scroll

    if (Math.abs(walk) > 5) {
      hasDragged = true;
      isGlobalDragging = true; // Activa el flag global para ignorar hovers
    }

    if (hasDragged) {
      e.preventDefault();
      row.scrollLeft = scrollLeftPos - walk;
    }
  });

  // Evita abrir enlaces o ejecutar acciones de clic si el usuario estaba arrastrando
  row.addEventListener('click', (e) => {
    if (hasDragged && window.innerWidth >= 768) {
      e.stopPropagation();
      e.preventDefault();
    }
  }, true);
});