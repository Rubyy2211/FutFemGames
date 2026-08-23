import random
from django.db.models import Count
from futfem.models import Equipo, Trayectoria, Jugadora, Pais, Trofeo

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
    Verifica que las 9 casillas (3x3) tengan al menos una jugadora 
    y que existan al menos 9 JUGADORAS DISTINTAS para resolver todo el tablero.
    """
    todos_equipos = cols + rows
    
    # 1. Traemos de una sola consulta las jugadoras de los 6 equipos seleccionados
    trayectorias = Trayectoria.objects.filter(
        equipo_id__in=todos_equipos
    ).values('equipo_id', 'jugadora_id')
    
    # Mapeamos: equipo_id -> conjunto de IDs de jugadoras
    equipos_jugadoras = {eq_id: set() for eq_id in todos_equipos}
    for t in trayectorias:
        equipos_jugadoras[t['equipo_id']].add(t['jugadora_id'])
        
    # 2. Construimos la lista de jugadoras posibles para cada una de las 9 casillas
    celdas = []
    for r in rows:
        for c in cols:
            # Intersección: jugadoras que han jugado en el equipo de la fila R y de la columna C
            jugadoras_casilla = equipos_jugadoras[r].intersection(equipos_jugadoras[c])
            
            # Si alguna de las 9 casillas no tiene jugadoras, el grid no sirve
            if not jugadoras_casilla:
                return False
            celdas.append(jugadoras_casilla)

    # 3. Algoritmo de Backtracking para asegurar que se pueden elegir 9 jugadoras sin repetir
    def resolver(casilla_idx, usadas):
        if casilla_idx == 9:
            return True # ¡Se encontraron 9 jugadoras distintas!
            
        for jugadora in celdas[casilla_idx]:
            if jugadora not in usadas:
                usadas.add(jugadora)
                if resolver(casilla_idx + 1, usadas):
                    return True
                usadas.remove(jugadora) # Backtrack
                
        return False

    return resolver(0, set())

def generar_grid():
    ligas_permitidas = [1, 2, 3, 4, 5, 6, 17] 
    
    equipos_validos = list(Equipo.objects.filter(
        equipocompeticion__competicion__id_liga__in=ligas_permitidas,
        equipocompeticion__es_principal=True
    ).values_list('id_equipo', flat=True).distinct())

    max_intentos = 100
    intentos = 0

    while intentos < max_intentos:
        intentos += 1
        
        # 1. Elegimos 3 columnas al azar
        cols = random.sample(equipos_validos, 3)
        
        # 2. Buscamos equipos conectados con las 3 columnas
        def obtener_equipos_conectados(equipo_id):
            jugadoras_ids = Trayectoria.objects.filter(equipo_id=equipo_id).values('jugadora_id')
            equipos_conectados = Trayectoria.objects.filter(jugadora_id__in=jugadoras_ids).values_list('equipo_id', flat=True)
            return set(equipos_conectados)
            
        set_col1 = obtener_equipos_conectados(cols[0])
        set_col2 = obtener_equipos_conectados(cols[1])
        set_col3 = obtener_equipos_conectados(cols[2])
        
        # Equipos válidos para filas (excluyendo los de las columnas y limitando a las ligas)
        filas_posibles = set_col1.intersection(set_col2).intersection(set_col3) - set(cols)
        filas_posibles = filas_posibles.intersection(set(equipos_validos))
        
        # 3. Si hay al menos 3 filas candidatas, probamos la combinación
        if len(filas_posibles) >= 3:
            rows = random.sample(list(filas_posibles), 3)
            
            # 🟢 VALIDACIÓN DE UNICIDAD: Comprobamos que las 9 casillas admitan jugadoras distintas
            if verificar_grid_resoluble(cols, rows):
                return {
                    "club1": str(cols[0]),
                    "club2": str(cols[1]),
                    "club3": str(cols[2]),
                    "club4": str(rows[0]),
                    "club5": str(rows[1]),
                    "club6": str(rows[2]),
                }

    # Grid por defecto de emergencia si supera los intentos
    return {
        "club1": "1", "club2": "2", "club3": "3",
        "club4": "4", "club5": "5", "club6": "6"
    }

def elegir_bingo_diario():
    # 1. Seleccionar 3 Países distintos
    paises_ids = list(Pais.objects.values_list('id_pais', flat=True))
    paises = random.sample(paises_ids, 3) if len(paises_ids) >= 3 else [1, 16, 7]

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
    trofeos_ids = list(Trofeo.objects.values_list('id', flat=True)) if Trofeo.objects.exists() else [1, 2, 3]
    trofeos = [random.choice(trofeos_ids)]

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
        "trofeos": trofeos,
        "edades": edades
    }