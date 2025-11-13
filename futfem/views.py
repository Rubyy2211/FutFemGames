from django.shortcuts import render
from django.http import JsonResponse
from django.db.models import Q
from .models import Jugadora, Trayectoria, Equipo

# Create your views here.
def jugadoraxnombre(request):
    nombre = request.GET.get('nombre', '').strip()
    if not nombre:
        return JsonResponse({'error': 'Nombre de jugadora no proporcionado'}, status=400)

    # Búsqueda parcial (case-insensitive)
    jugadoras = (
        Jugadora.objects
        .filter(
            Q(Nombre__icontains=nombre) |
            Q(Apodo__icontains=nombre) |
            Q(Apellidos__icontains=nombre)
        )
        .select_related('Nacionalidad', 'Posicion')  # optimiza las relaciones
    )

    if not jugadoras.exists():
        return JsonResponse({'error': 'No se encontraron jugadoras con ese nombre.'}, status=404)

    data = []
    for j in jugadoras:
        data.append({
            'id_jugadora': j.id_jugadora,
            'Nombre_Completo': f"{j.Nombre} {j.Apellidos}",
            'imagen': j.imagen or './static/img/predeterm.jpg',
            'Apodo': j.Apodo,
            'Nacimiento': j.Nacimiento.strftime("%Y-%m-%d"),
            'Nacionalidad': j.Nacionalidad.nombre if j.Nacionalidad else None,
            'Posicion': j.Posicion.nombre if j.Posicion else None,
        })

    return JsonResponse(data, safe=False)

def jugadora_trayectoria(request):
    id_jugadora = request.GET.get('id')

    if not id_jugadora:
        return JsonResponse({'error': 'ID de jugadora no proporcionado'}, status=400)

    try:
        id_jugadora = int(id_jugadora)
    except ValueError:
        return JsonResponse({'error': 'ID de jugadora inválido'}, status=400)

    # Traer las trayectorias filtrando la liga != 17
    trayectorias = Trayectoria.objects.filter(
    jugadora_id=id_jugadora
    ).exclude(
    equipo__liga__id_liga=17
    ).select_related('equipo', 'jugadora').order_by('años')

    data = []
    for t in trayectorias:
        equipo = t.equipo
        jug = t.jugadora

        escudo = None
        if equipo.escudo:
            escudo = equipo.escudo

        imagen_jugadora = None
        if jug.imagen:
            imagen_jugadora = jug.imagen

        data.append({
            'trayectoria_id': t.id,
            'jugadora': jug.id_jugadora,
            'equipo': equipo.id_equipo,
            'años': t.años,
            'imagen': t.imagen,  # o t.imagen codificada si quieres
            'equipo_actual': t.equipo_actual,
            'escudo': escudo,
            'liga': equipo.liga.id_liga if equipo.liga else None,
            'nombre': equipo.nombre,
            'ImagenJugadora': imagen_jugadora,
        })

    return JsonResponse(data, safe=False)