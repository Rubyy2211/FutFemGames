// ============================================================
// ELEMENTOS PRINCIPALES
// ============================================================

const botones = document.querySelectorAll('.game-button');
const linksSelector = document.querySelectorAll('#selector a');
const bgContainer = document.getElementById('video-bg-container');


// ============================================================
// CAPA DE IMAGEN DE FONDO
// ============================================================

let gameBgImage = document.getElementById('game-bg-image');

if (bgContainer && !gameBgImage) {

  gameBgImage = document.createElement('div');
  gameBgImage.id = 'game-bg-image';

  gameBgImage.style.position = 'absolute';
  gameBgImage.style.inset = '0';
  gameBgImage.style.backgroundPosition = 'center';
  gameBgImage.style.backgroundSize = 'cover';
  gameBgImage.style.backgroundRepeat = 'no-repeat';
  gameBgImage.style.pointerEvents = 'none';
  gameBgImage.style.opacity = '0';
  gameBgImage.style.zIndex = '1';

  bgContainer.appendChild(gameBgImage);
}


// ============================================================
// ELEMENTOS H2
// ============================================================

const dayH2 = document.querySelector(
  '#daily-games h2, #diarios h2'
);

const regH2 = document.querySelector(
  '#regular-games h2, #regulares h2'
);

const defaultDayText = dayH2
  ? dayH2.textContent
  : 'Diarios';

const defaultRegText = regH2
  ? regH2.textContent
  : 'Regulares';

// ============================================================
// ELEMENTOS P
// ============================================================

const dayDescription = document.getElementById(
  'daily-games-description'
);

const regDescription = document.getElementById(
  'regular-games-description'
);

const defaultDayDescription = dayDescription
  ? dayDescription.textContent
  : 'Descubre juegos diarios de Futfem';

const defaultRegDescription = regDescription
  ? regDescription.textContent
  : 'Descubre juegos regulares de Futfem';


// ============================================================
// FUNCIÓN: CAMBIAR TEXTO DEL H2
// ============================================================

function updateH2Text(h2Element, newText) {

  if (!h2Element || h2Element.textContent === newText) {
    return;
  }

  gsap.killTweensOf(h2Element);

  gsap.to(h2Element, {
    autoAlpha: 0,
    y: -60,
    duration: 0.12,
    ease: "power1.in",

    onComplete: () => {

      h2Element.textContent = newText;

      console.log("Nuevo texto del H2:", newText);
      h2Element.dataset.gameTitle = newText;

      gsap.set(h2Element, {
        y: -40
      });

      gsap.to(h2Element, {
        autoAlpha: 1,
        y: -50,
        duration: 0.25,
        ease: "back.out(1.5)"
      });

    }
  });
}

// ============================================================
// FUNCIÓN: CAMBIAR TEXTO DEL P
// ============================================================

function updateDescription(element, newText) {

  if (!element || element.textContent === newText) {
    return;
  }

  gsap.killTweensOf(element);

  gsap.to(element, {
    autoAlpha: 0,
    y: -15,
    duration: 0.12,
    ease: "power1.in",

    onComplete: () => {

      element.textContent = newText;

      gsap.set(element, {
        y: -10
      });

      gsap.to(element, {
        autoAlpha: 1,
        y: 0,
        duration: 0.25,
        ease: "back.out(1.5)"
      });

    }
  });
}

// ============================================================
// FUNCIÓN: DETECTAR SI UNA FECHA ES HOY
// ============================================================

function esHoy(fechaString) {

    if (!fechaString) {
        return false;
    }

    const hoy = new Intl.DateTimeFormat('es-ES', {
        timeZone: 'Europe/Madrid',
        day: '2-digit',
        month: '2-digit',
        year: 'numeric'
    }).format(new Date());

    return fechaString === hoy;
}

// ============================================================
// FUNCIÓN: ACTUALIZAR ESTADO DE LOS DIARIOS
// ============================================================

function actualizarEstadoDiario(ultimaVezJugado) {

  const dailyStatusContainer = document.getElementById('daily-games-status');
  const icon = document.getElementById('daily-status-icon');
  const message = document.getElementById('daily-status-message');

  if (!icon || !message) {
    return;
  }

  if (esHoy(ultimaVezJugado)) {

    dailyStatusContainer.classList.add('played-today');
    dailyStatusContainer.classList.remove('not-played-today');
    icon.textContent = '✓';
    message.textContent = 'Ya has jugado a este juego hoy';

  } else {

    dailyStatusContainer.classList.add('not-played-today');
    dailyStatusContainer.classList.remove('played-today');
    icon.textContent = '🎮';
    message.textContent = 'Juega los diarios de hoy';

  }

}

// ============================================================
// FUNCIÓN: RESTABLECER BOTONES
// ============================================================

function resetAllGameButtons() {

  if (botones.length === 0) {
    return;
  }

  botones.forEach(btn => {

    btn.classList.remove('active');

    gsap.to(btn, {
      scale: 0.9,
      opacity: 1,
      duration: 0.3
    });

  });

}


// ============================================================
// FUNCIÓN: CAMBIAR FONDO
// ============================================================

function changeBackground(bg) {

  if (!bg || !gameBgImage) {
    return;
  }

  console.log("Cambiando fondo a:", bg);

  gsap.killTweensOf(gameBgImage);

  gsap.to(gameBgImage, {
    opacity: 0,
    duration: 0.15,
    ease: "power1.in",

    onComplete: () => {

      gameBgImage.style.backgroundImage =
        `linear-gradient(
          rgba(0,0,0,0),
          rgba(0,0,0,0)
        ), url("${bg}")`;

      gsap.to(gameBgImage, {
        opacity: 1,
        duration: 0.35,
        ease: "power2.out"
      });

    }
  });
}


// ============================================================
// FUNCIÓN: RESTAURAR FONDO DE LA SECCIÓN
// ============================================================

function restoreSectionBackground(link) {

  if (!link) {
    return;
  }

  const sectionBg = link.dataset.bg;

  if (sectionBg) {
    changeBackground(sectionBg);
  }
}


// ============================================================
// FUNCIÓN: RESTAURAR ESTADO DE LA SECCIÓN
// ============================================================

function restoreSectionState(link) {

  if (!link) {
    return;
  }

  const href = link.getAttribute('href');

  // ----------------------------------------------------------
  // DIARIOS
  // ----------------------------------------------------------

  if (
    href === '#diarios' ||
    link.querySelector('p')?.textContent.trim().toLowerCase() === 'diarios'
  ) {

    if (dayH2) {
      updateH2Text(
        dayH2,
        defaultDayText
      );
    }

  }


  // ----------------------------------------------------------
  // REGULARES
  // ----------------------------------------------------------

  else if (
    href === '#regulares' ||
    link.querySelector('p')?.textContent.trim().toLowerCase() === 'regulares'
  ) {

    if (regH2) {
      updateH2Text(
        regH2,
        defaultRegText
      );
    }

  }


  // ----------------------------------------------------------
  // FONDO
  // ----------------------------------------------------------

  restoreSectionBackground(link);

}


// ============================================================
// HOVER DE LOS GAME BUTTONS
// ============================================================

if (botones.length > 0) {

  botones.forEach(card => {

    card.addEventListener('mouseenter', () => {

      // --------------------------------------------------------
      // OBTENER DATOS
      // --------------------------------------------------------

      const { bg, titulo, descripcion, ultimaVezJugado } = card.dataset;

      /*console.log("GAME BUTTON:", card);
      console.log("DATA BG:", bg);
      console.log("DATA TITULO:", titulo);
      console.log("DATA DESCRIPCION:", descripcion);
      console.log("DATA ULTIMA VEZ JUGADO:", ultimaVezJugado);*/

      actualizarEstadoDiario(ultimaVezJugado);


      // --------------------------------------------------------
      // DETECTAR SECCIÓN
      // --------------------------------------------------------

      const parentDaily = card.closest(
        '#diarios, #daily-games'
      );

      const parentRegular = card.closest(
        '#regulares, #regular-games'
      );


      // --------------------------------------------------------
      // CAMBIAR H2
      // --------------------------------------------------------

      if (parentDaily) {

          if (dayH2 && titulo) {
              updateH2Text(dayH2, titulo);
          }

          if (dayDescription && descripcion) {
              updateDescription(dayDescription, descripcion);
          }

      } else if (parentRegular) {

          if (regH2 && titulo) {
              updateH2Text(regH2, titulo);
          }

          if (regDescription && descripcion) {
              updateDescription(regDescription, descripcion);
          }
      }


      // --------------------------------------------------------
      // CAMBIAR FONDO
      // --------------------------------------------------------

      if (bg) {
        changeBackground(bg);
      }


      // --------------------------------------------------------
      // ESTADO DE LOS BOTONES
      // --------------------------------------------------------

      const sectionContainer =
        parentDaily ||
        parentRegular ||
        null;

      if (!sectionContainer) {
        return;
      }

      const sectionButtons =
        sectionContainer.querySelectorAll(
          '.game-button'
        );

      if (sectionButtons.length === 0) {
        return;
      }


      sectionButtons.forEach(other => {

        if (other === card) {

          other.classList.add('active');

          gsap.to(other, {
            scale: 0.95,
            opacity: 1,
            duration: 0.3
          });

        } else {

          other.classList.remove('active');

          gsap.to(other, {
            scale: 0.9,
            opacity: 0.7,
            duration: 0.3
          });

        }

      });

    });


    // ----------------------------------------------------------
    // MOUSELEAVE
    // ----------------------------------------------------------

    card.addEventListener('mouseleave', () => {

      // No hacemos nada.
      // El botón y su fondo permanecen activos.

    });

  });

}


// ============================================================
// ANIMACIÓN DEL MENÚ PRINCIPAL
// ============================================================

const secciones = document.querySelectorAll(
  '#diarios, #regulares'
);


// ============================================================
// SECCIÓN INICIAL
// ============================================================

const inicialSection =
  document.getElementById('diarios');

let seccionActiva =
  inicialSection;


// ============================================================
// LINK ACTIVO INICIAL
// ============================================================

let linkActivo = null;

if (linksSelector.length > 0) {

  linkActivo = Array.from(linksSelector).find(link => {

    const href =
      link.getAttribute('href');

    return (
      href === '#diarios' ||
      link
        .querySelector('p')
        ?.textContent
        .trim()
        .toLowerCase() === 'diarios'
    );

  }) || linksSelector[0];

}


// ============================================================
// ESTADO INICIAL DE LAS SECCIONES
// ============================================================

if (secciones.length > 0) {

  secciones.forEach(sec => {

    if (sec === inicialSection) {

      gsap.set(sec, {
        autoAlpha: 1,
        display: 'flex',
        y: 0
      });

      const infos =
        sec.querySelectorAll('.panel-info');

      if (infos.length > 0) {

        gsap.set(infos, {
          autoAlpha: 1,
          y: 0
        });

      }

    } else {

      gsap.set(sec, {
        autoAlpha: 0,
        display: 'none',
        y: 10
      });

      const infos =
        sec.querySelectorAll('.panel-info');

      if (infos.length > 0) {

        gsap.set(infos, {
          autoAlpha: 0,
          y: 15
        });

      }

    }

  });

}


// ============================================================
// INICIALIZAR LINKS DEL SELECTOR
// ============================================================

if (linksSelector.length > 0) {

  linksSelector.forEach(link => {

    const isInitialActive =
      link === linkActivo;


    // ----------------------------------------------------------
    // LINK ACTIVO INICIAL
    // ----------------------------------------------------------

    if (isInitialActive) {

      link.classList.add('active');

      gsap.set(link, {

        "--arrowOpacity": 1,
        "--arrowScale": 1,
        "--arrowYTop": "0px",
        "--arrowYBottom": "0px"

      });


      // --------------------------------------------------------
      // FONDO INICIAL
      // --------------------------------------------------------

      const initBg =
        link.dataset.bg;

      if (initBg) {
        changeBackground(initBg);
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


    // ----------------------------------------------------------
    // OBTENER SECCIÓN DESTINO
    // ----------------------------------------------------------

    const href =
      link.getAttribute('href');

    let targetId =
      href && href.startsWith('#')
        ? href
        : null;


    if (!targetId) {

      const text =
        link
          .querySelector('p')
          ?.textContent
          .trim()
          .toLowerCase();

      if (text) {
        targetId = `#${text}`;
      }

    }


    const targetSection =
      targetId
        ? document.querySelector(targetId)
        : null;


    // ----------------------------------------------------------
    // HOVER DEL LINK
    // ----------------------------------------------------------

    link.addEventListener('mouseenter', () => {

      if (link === linkActivo) {
        return;
      }


      // --------------------------------------------------------
      // SONIDO
      // --------------------------------------------------------

      /*
      if (hoverSound) {

        hoverSound.currentTime = 0;

        hoverSound.play().catch(() => {});

      }
      */


      // --------------------------------------------------------
      // ANIMACIÓN DE FLECHAS
      // --------------------------------------------------------

      linksSelector.forEach(otherLink => {

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


      // --------------------------------------------------------
      // ACTUALIZAR LINK ACTIVO
      // --------------------------------------------------------

      linkActivo = link;


      // --------------------------------------------------------
      // CAMBIAR FONDO
      // --------------------------------------------------------

      const newBg =
        link.dataset.bg;

      if (newBg) {
        changeBackground(newBg);
      }


      // --------------------------------------------------------
      // CAMBIAR SECCIÓN
      // --------------------------------------------------------

      if (
        targetSection &&
        targetSection !== seccionActiva
      ) {


        // ------------------------------------------------------
        // RESTAURAR TÍTULOS
        // ------------------------------------------------------

        if (dayH2) {

          updateH2Text(
            dayH2,
            defaultDayText
          );

        }

        if (regH2) {

          updateH2Text(
            regH2,
            defaultRegText
          );

        }

        if (dayDescription) {
            updateDescription(dayDescription, defaultDayDescription);
        }

        if (regDescription) {
            updateDescription(regDescription, defaultRegDescription);
        }


        // ------------------------------------------------------
        // RESTAURAR BOTONES
        // ------------------------------------------------------

        resetAllGameButtons();


        // ------------------------------------------------------
        // OCULTAR SECCIÓN ACTUAL
        // ------------------------------------------------------

        if (seccionActiva) {

          gsap.killTweensOf(
            seccionActiva
          );

          gsap.to(
            seccionActiva,
            {
              autoAlpha: 0,
              display: 'none',
              y: -10,
              duration: 0.15
            }
          );

        }


        // ------------------------------------------------------
        // MOSTRAR NUEVA SECCIÓN
        // ------------------------------------------------------

        gsap.killTweensOf(
          targetSection
        );

        gsap.set(
          targetSection,
          {
            y: 15
          }
        );

        gsap.to(
          targetSection,
          {

            duration: 0.35,

            autoAlpha: 1,

            display: 'flex',

            y: 0,

            delay: 0.1,

            ease: "power2.out"

          }
        );


        seccionActiva =
          targetSection;


        // ------------------------------------------------------
        // RESTAURAR FONDO DE LA NUEVA SECCIÓN
        // ------------------------------------------------------

        restoreSectionBackground(link);

      }

    });

  });

}