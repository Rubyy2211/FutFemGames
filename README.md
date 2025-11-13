# FutFemGames
El fútbol femenino ha ido en constante crecimiento en los últimos años, pasando de ser un deporte no profesional a obtener un reconocimiento y seguimiento bastante grandes. Sin embargo, a pesar de este constante crecimiento la falta de plataformas digitales y de contenido sobre este mundo sigue siendo bastante notoria, lo que aleja a este deporte de recibir nuevos seguidores.

Por esta razón se ha decidido crear ‘FutFemGames’, una plataforma web que pretende ofrecer una experiencia didáctica y divertida a los aficionados más experimentados y a los nuevos, a través de minijuegos que pondrán a prueba sus conocimientos sobre jugadoras, equipos, trayectorias… La plataforma también permitirá a los usuarios descubrir información sobre las jugadoras.

## Estructura

```text
FutFemGames/
├── 📁 FutFemGames/             # Configuración del proyecto
│   ├── 🐍 settings.py          # Configuración global
│   ├── 🔗 urls.py              # Rutas principales
│   └── ...
├── 📁 futfem/                  # App Principal
│   ├── 🖼️ media/               # Escudos y uploads
│   ├── 🎨 static/              # CSS/JS general
│   ├── 📄 templates/           # HTML principal
│   ├── 🗃️ models.py            # Modelos de BBDD
│   └── 👁️ views.py             # Lógica de vistas
├── 📁 minijuegos/              # App Minijuegos
│   ├── 🎨 static/              # Assets de juegos(img, js, css)
│   ├── 📄 templates/           # HTML de juegos (Wordle, etc.)
│   └── 👁️ views.py             # Lógica de juegos
├── ⚙️ manage.py
