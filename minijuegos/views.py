import json
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, Http404
from django.shortcuts import get_object_or_404
from django.utils import timezone
from datetime import date
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import never_cache
from .utils import generar_grid, api_random_player, obtener_id_jugadora_trayectoria, api_random_team, elegir_bingo_diario
from .models import Pista  # Asegúrate de tener el modelo Pista


def index(request):
    return render(request, 'minijuegos/index.html')

def minijuegos(request):
    return render(request, 'minijuegos/minijuegos.html')

@login_required
def loading(request):
    # Obtiene el parámetro ?url= que le pasas desde redirect.js
    url_final = request.GET.get('url', '')
    # Lo pasa al template para que el JS lo use
    return render(request, 'minijuegos/carga.html', {'url_final': url_final})

def nosotros(request):
    # Obtiene el parámetro ?url= que le pasas desde redirect.js
    # Lo pasa al template para que el JS lo use
    return render(request, 'nosotros.html')

@never_cache
@login_required
def futfemTrajectory(request):
        return render(request, 'guesstrayectoria/trayectoria.html')

@never_cache
@login_required
def futfemGrid(request):
        return render(request, 'grid/grid.html')

@never_cache
@login_required
def futfemBingo(request):
        return render(request, 'bingo/bingo.html')

@never_cache
@login_required
def futfemWordle(request):
        return render(request, 'wordle/wordle.html')

@never_cache
@login_required
def futfemMates(request):
        return render(request, 'companyeras/companyeras.html')

@never_cache
@login_required
def futfemGuess(request):
        return render(request, 'guess/adivina2.html')

@never_cache
@login_required
def futfemGuess2(request):
        return render(request, 'guess/adivina2.html')

@never_cache
@login_required
def futfemHigherLower(request):
        return render(request, 'higherlower/higher-lower.html')

@never_cache
@login_required
def futfemXIClubs(request):
        return render(request, 'XI_Clubs.html')

@never_cache
def juegoxid(request):
    id_juego = request.GET.get('id_juego')

    if not id_juego:
        return JsonResponse({'error': 'No se proporcionó id_juego.'}, status=400)

    try:
        pista = Pista.objects.get(juego=id_juego)
    except Pista.DoesNotExist:
        return JsonResponse({'error': 'No se encontraron datos para el id_juego proporcionado.'}, status=404)

    datos = json.loads(pista.valor)

    hoy_str = timezone.localtime(timezone.now()).date().isoformat()
    # Si pista.valor ya es un dict, no usar json.loads
    # Si la fecha guardada no es la de hoy, recalculamos usando las funciones auxiliares
    if datos.get("fecha") != hoy_str:

        j_id = int(id_juego)    

        if j_id == 1:
            # Juego de Trayectoria (asegura > 1 equipo)
            datos["idJugadora"] = obtener_id_jugadora_trayectoria()
                
        elif j_id in [2, 3, 5]: 
            # Juegos normales (Wordle, Adivina, etc.)
            datos["idJugadora"] = api_random_player()
                
        elif j_id == 4: # Grid
            datos.update(generar_grid())
                
        elif j_id == 6: # FutFemBingo
            datos.update(elegir_bingo_diario())
                
        elif j_id == 7: # Futfem Clubs
            datos["equipo"] = api_random_team()
            datos["temporada"] = "2024" # O lo que necesites
                
        # Guardamos la nueva fecha y los datos actualizados
        datos["fecha"] = hoy_str
        pista.valor = json.dumps(datos)
        pista.save()

    return JsonResponse({'success': pista.valor})