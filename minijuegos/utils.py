import random
from django.db.models import Count
from futfem.models import Equipo, Trayectoria, Jugadora, Pais, JugadoraPais , Trofeo

def api_random_player():
    jugadoras = Jugadora.objects.all()
    if not jugadoras.exists():
        return None
    jugadora = random.choice(list(jugadoras))
    return str(jugadora.id_jugadora)

def obtener_id_jugadora_trayectoria():
    # 1. Anotamos cuántos registros de trayectoria tiene cada jugadora
    # OJO: Cambia 'trayectoria' por el related_name o el nombre de tu modelo en minúsculas
    jugadoras = Jugadora.objects.annotate(
        num_etapas=Count('trayectoria') 
    ).filter(
        num_etapas__gt=1  # 🟢 __gt=1 significa "Greater Than 1" (Mayor que 1)
    )

    if not jugadoras.exists():
        return None

    # 2. Elegimos una aleatoria
    return str(random.choice(list(jugadoras)).id_jugadora)

def api_random_team():
    ligas_permitidas = [1, 2, 3, 4, 5, 6, 17] 
    equipos = Equipo.objects.filter(
        equipocompeticion__competicion__id_liga__in=ligas_permitidas,
        equipocompeticion__es_principal=True
    ).distinct()
    
    if not equipos.exists():
        return None
    equipo = random.choice(list(equipos))
    return str(equipo.id_equipo)

def verificar_grid_resoluble(cols, rows):
    """
    Verifica que las 9 casillas tengan jugadoras y que exista
    al menos una solución utilizando 9 JUGADORAS DISTINTAS.

    Se utiliza backtracking con MRV:
    siempre se intenta resolver primero la casilla que tiene
    menos jugadoras disponibles.
    """

    todos_equipos = list(set(cols + rows))

    # Traemos las trayectorias de los 6 equipos
    trayectorias = Trayectoria.objects.filter(
        equipo_id__in=todos_equipos
    ).values('equipo_id', 'jugadora_id')

    # equipo_id -> conjunto de jugadoras
    equipos_jugadoras = {eq_id: set() for eq_id in todos_equipos}

    for t in trayectorias:
        equipos_jugadoras[t['equipo_id']].add(t['jugadora_id'])

    # Construimos las 9 celdas
    celdas = []

    for r in rows:
        for c in cols:

            jugadoras_casilla = (
                equipos_jugadoras[r]
                .intersection(equipos_jugadoras[c])
            )

            # Si una casilla está vacía, el grid no sirve
            if not jugadoras_casilla:
                return False

            celdas.append(jugadoras_casilla)

    # ---------------------------------------------------------
    # Backtracking con MRV
    # ---------------------------------------------------------

    def resolver(celdas_pendientes, usadas):

        # Todas las casillas resueltas
        if not celdas_pendientes:
            return True

        # Para cada casilla calculamos las jugadoras disponibles
        opciones = []

        for idx, jugadoras in celdas_pendientes:
            disponibles = jugadoras - usadas

            # Si una casilla se queda sin ninguna jugadora
            # disponible, esta rama no puede resolverse
            if not disponibles:
                return False

            opciones.append(
                (len(disponibles), idx, disponibles)
            )

        # MRV:
        # primero resolvemos la casilla con menos opciones
        opciones.sort(key=lambda x: x[0])

        _, idx, disponibles = opciones[0]

        nuevas_pendientes = [
            item
            for item in celdas_pendientes
            if item[0] != idx
        ]

        for jugadora in disponibles:

            usadas.add(jugadora)

            if resolver(nuevas_pendientes, usadas):
                return True

            usadas.remove(jugadora)

        return False

    celdas_con_indice = list(enumerate(celdas))

    return resolver(celdas_con_indice, set())


def generar_grid():

    ligas_permitidas = [1, 2, 3, 4, 5, 6, 17]

    equipos_validos = list(
        Equipo.objects.filter(
            equipocompeticion__competicion__id_liga__in=ligas_permitidas,
            equipocompeticion__es_principal=True
        )
        .values_list('id_equipo', flat=True)
        .distinct()
    )

    max_intentos = 100
    intentos = 0

    while intentos < max_intentos:

        intentos += 1

        # ---------------------------------------------------------
        # 1. Elegimos 3 columnas
        # ---------------------------------------------------------

        cols = random.sample(equipos_validos, 3)

        # ---------------------------------------------------------
        # 2. Encontramos equipos conectados con las 3 columnas
        # ---------------------------------------------------------

        def obtener_equipos_conectados(equipo_id):

            jugadoras_ids = Trayectoria.objects.filter(
                equipo_id=equipo_id
            ).values('jugadora_id')

            equipos_conectados = Trayectoria.objects.filter(
                jugadora_id__in=jugadoras_ids
            ).values_list(
                'equipo_id',
                flat=True
            )

            return set(equipos_conectados)

        set_col1 = obtener_equipos_conectados(cols[0])
        set_col2 = obtener_equipos_conectados(cols[1])
        set_col3 = obtener_equipos_conectados(cols[2])

        # Equipos que comparten al menos una jugadora
        # con las 3 columnas
        filas_posibles = (
            set_col1
            .intersection(set_col2)
            .intersection(set_col3)
        )

        # No queremos repetir equipos de las columnas
        filas_posibles -= set(cols)

        # Solo equipos de las ligas permitidas
        filas_posibles = filas_posibles.intersection(
            set(equipos_validos)
        )

        # ---------------------------------------------------------
        # 3. Necesitamos al menos 3 filas
        # ---------------------------------------------------------

        if len(filas_posibles) < 3:
            continue

        # ---------------------------------------------------------
        # 4. Probamos varias combinaciones de filas
        # ---------------------------------------------------------

        filas_lista = list(filas_posibles)

        random.shuffle(filas_lista)

        combinaciones_probadas = 0

        for i in range(len(filas_lista)):

            for j in range(i + 1, len(filas_lista)):

                for k in range(j + 1, len(filas_lista)):

                    rows = [
                        filas_lista[i],
                        filas_lista[j],
                        filas_lista[k]
                    ]

                    combinaciones_probadas += 1

                    # -------------------------------------------------
                    # 5. Comprobamos que el grid pueda resolverse
                    #    con 9 jugadoras diferentes
                    # -------------------------------------------------

                    if verificar_grid_resoluble(cols, rows):

                        return {
                            "club1": str(cols[0]),
                            "club2": str(cols[1]),
                            "club3": str(cols[2]),
                            "club4": str(rows[0]),
                            "club5": str(rows[1]),
                            "club6": str(rows[2]),
                        }

                    # Limitamos las combinaciones para no hacer
                    # demasiadas consultas/procesamiento
                    if combinaciones_probadas >= 30:
                        break

                if combinaciones_probadas >= 30:
                    break

            if combinaciones_probadas >= 30:
                break

    # ---------------------------------------------------------
    # Grid de emergencia
    # ---------------------------------------------------------

    return {
        "club1": "1",
        "club2": "2",
        "club3": "3",
        "club4": "4",
        "club5": "5",
        "club6": "6"
    }

def elegir_bingo_diario():
    # 1. Seleccionar 3 Países distintos
    paises_ids = list(JugadoraPais.objects .filter(es_primaria=True) .values_list('pais', flat=True) .distinct()) # deben ser Ids únicos de países que tengan jugadoras como pais principal

    if len(paises_ids) >= 3:
        paises = random.sample(paises_ids, 3)
    else:
        paises = paises_ids

    # 2. Seleccionar 3 Equipos distintos de ligas principales
    ligas_permitidas = [1, 2, 3, 4, 5, 6, 17]
    equipos_qs = Equipo.objects.filter(
        equipocompeticion__competicion__id_liga__in=ligas_permitidas,
        equipocompeticion__es_principal=True
    ).values_list('id_equipo', flat=True).distinct()
    
    equipos_ids = list(equipos_qs)
    equipos = random.sample(equipos_ids, 3) if len(equipos_ids) >= 3 else [1, 18, 2]

    # 3. Seleccionar 3 Ligas distintas
    ligas = random.sample(ligas_permitidas, 3)

    # 4. Seleccionar 1 Trofeo
    # trofeos_ids = list(Trofeo.objects.values_list('id', flat=True)) if Trofeo.objects.exists() else [1, 2, 3]
    # trofeos = [random.choice(trofeos_ids)]

    # 5. Seleccionar 2 Criterios de edad distintos
    pool_edades = [
        {"op": ">", "val": 30, "img": "/static/img/edades/mayor30.png"},
        {"op": "<", "val": 21, "img": "/static/img/edades/menor21.png"},
        {"op": "=", "val": 25, "img": "/static/img/edades/igual25.png"},
        {"op": ">", "val": 28, "img": "/static/img/edades/mayor28.png"},
        {"op": "<", "val": 23, "img": "/static/img/edades/menor23.png"},
        {"op": "=", "val": 30, "img": "/static/img/edades/igual30.png"}
    ]
    edades = random.sample(pool_edades, 2)

    return {
        "paises": paises,
        "equipos": equipos,
        "ligas": ligas,
        #"trofeos": trofeos,
        "edades": edades
    }