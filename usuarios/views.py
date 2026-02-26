from django.shortcuts import render, redirect
from .models import Usuario, Racha, Juego
from django.db import connection, IntegrityError
from django.utils import timezone
from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.hashers import make_password, check_password
from django.contrib.auth.models import update_last_login # Importa esto
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
def login_view(request):

    if request.user.is_authenticated:
        return redirect('/') # Si ya está dentro, que no vea el formulario
    
    if request.method == 'POST':
        usuario_input = request.POST['usuario']
        password_input = request.POST['password']

        try:
            usuario = Usuario.objects.get(username=usuario_input)
        except Usuario.DoesNotExist:
            return render(request, 'login.html', {
                'error': 'Usuario o contraseña incorrectos'
            })

        if check_password(password_input, usuario.password):

            if not usuario.is_active:
                return render(request, 'login.html', {'error': 'Esta cuenta ha sido desactivada.'})
            
            login(request, usuario) # Esto actualiza last_login y crea la sesión
            request.session['usuario_id'] = usuario.id
            request.session['usuario_nombre'] = usuario.username
            request.session['rol_id'] = usuario.rol
            return redirect('/')
        
        else:
            return render(request, 'login.html', {
                'error': 'Usuario o contraseña incorrectos'
            })

    return render(request, 'login.html')

def logout_view(request):
     # Eliminar todos los datos de la sesión
    request.session.flush()  # borra la sesión y la cookie
    logout(request)
    # Redirigir al login
    return redirect('login')

def sesion_view(request):
    if request.user.is_authenticated:
        # Si usas AbstractUser, los datos están en el objeto 'user'
        return JsonResponse({
            'autenticado': True,
            'id': request.user.id,
            'rol': getattr(request.user, 'rol', None), # Usa getattr por seguridad
            'username': request.user.username
        })
    
    # IMPORTANTE: No devuelvas 401 si el frontend se vuelve loco al recibir errores
    # Es mejor devolver 200 con autenticado: False para que el JS sepa qué hacer
    return JsonResponse({
        'autenticado': False,
        'mensaje': 'No hay sesión activa'
    }, status=200)

def registro_view(request):
    if request.method == 'POST':
        usuario = request.POST['usuario']
        password = request.POST['password']
        password2 = request.POST['password2']

        if password != password2:
            return render(request, 'registro.html', {
                'error': 'Las contraseñas no coinciden'
            })

        try:
            Usuario.objects.create(
                username=usuario, 
                password=make_password(password), # Django lo mapeará a 'Contrasena'
                rol=1,
                is_active=True,
                is_staff=False,
                is_superuser=False,
                date_joined=timezone.now()
            )
        except IntegrityError:
            return render(request, 'registro.html', {
                'error': 'El usuario ya existe'
            })

        return redirect('/api/login/')

    return render(request, 'registro.html')

def perfil_view(request):
    """
    Muestra la página de perfil del usuario logueado.
    """
    if request.session.get('rol_id') not in [1,2]:
        return redirect('/')  # o HttpResponseForbidden()
    # Verificamos si hay sesión activa
    usuario_obj = None
    if 'usuario_id' in request.session:
        try:
            # Traemos el usuario junto con su jugadora_favorita
            usuario_obj = Usuario.objects.select_related('jugadora_favorita').get(
                id=request.session['usuario_id']
            )
        except Usuario.DoesNotExist:
            # Si el usuario no existe, borramos sesión y redirigimos al login
            request.session.flush()
            return redirect('login')

    if not usuario_obj:
        # Si no hay usuario en sesión, redirigimos al login
        return redirect('login')

    # Contexto para el template
    context = {
        'usuario': usuario_obj,
        'jugadora_favorita': usuario_obj.jugadora_favorita  # puede ser None
    }

    return render(request, 'perfil.html', context)

def obtener_rachas(request):
    """
    Devuelve las rachas de un usuario.
    - Si se pasa `juego`, devuelve solo ese juego.
    - Si no, devuelve todas.
    """
    usuario_id = request.GET.get('usuario')
    juego_id = request.GET.get('juego')

    if not usuario_id:
        return JsonResponse({'error': 'Falta usuario'}, status=400)

    filtros = {'usuario_id': usuario_id}
    if juego_id:
        filtros['juego_id'] = juego_id

    rachas_qs = (
        Racha.objects
        .filter(**filtros)
        .select_related('juego')
        .values(
            'usuario_id',
            'racha_actual',
            'mejor_racha',

            # 🔽 campos del juego
            'juego__id',
            'juego__nombre',
            'juego__slug',
        )
    )

    data = [
        {
            'usuario_id': r['usuario_id'],
            'racha_actual': r['racha_actual'],
            'mejor_racha': r['mejor_racha'],
            'juego': {
                'id': r['juego__id'],
                'nombre': r['juego__nombre'],
                'slug': r['juego__slug'],
            }
        }
        for r in rachas_qs
    ]

    # SI SE PIDE UN JUEGO ESPECÍFICO Y NO HAY RACHA, ENVIAMOS VALORES EN 0
    if not data and juego_id:
        return JsonResponse([{
            'usuario_id': int(usuario_id),
            'racha_actual': 0,
            'mejor_racha': 0,
            'ultima_respuesta': None,
            'juego': {'id': int(juego_id), 'nombre': '', 'slug': ''}
        }], safe=False)

    return JsonResponse(data, safe=False)

@csrf_exempt
@require_POST
def juego_racha(request):
    try:
        # 1. Obtener datos (usamos 0 como fallback para números)
        racha_actual = int(request.POST.get('racha', 0))
        juego_id = int(request.POST.get('juego'))
        usuario_id = int(request.POST.get('user'))
        ultima_respuesta = request.POST.get('last_answer')
        
        # Si no envían mejor_racha, usamos la racha_actual por defecto
        mejor_racha_input = request.POST.get('mejor_racha')
        mejor_racha_input = int(mejor_racha_input) if mejor_racha_input else racha_actual

        # 2. Buscar si ya existe la racha
        racha_obj = Racha.objects.filter(usuario_id=usuario_id, juego_id=juego_id).first()

        if racha_obj:
            # ACTUALIZAR
            racha_obj.racha_actual = racha_actual
            
            # Solo actualizamos la mejor racha si la recibida es mayor a la que ya tenemos
            if mejor_racha_input > racha_obj.mejor_racha:
                racha_obj.mejor_racha = mejor_racha_input
            
            if ultima_respuesta:
                racha_obj.ultima_respuesta = ultima_respuesta
            
            # IMPORTANTE: Quitamos update_fields para evitar que Django ignore campos
            racha_obj.save()
        else:
            # CREAR
            Racha.objects.create(
                usuario_id=usuario_id,
                juego_id=juego_id,
                racha_actual=racha_actual,
                mejor_racha=mejor_racha_input,
                ultima_respuesta=ultima_respuesta
            )

        return JsonResponse({
            'success': True,
            'racha_actual': racha_actual,
            'mejor_racha': mejor_racha_input
        })

    except Exception as e:
        print(f"Error grave en racha: {str(e)}")
        return JsonResponse({'error': str(e)}, status=500)

def obtener_ultima_respuesta(request):
    """
    Devuelve la última respuesta de un usuario para un juego concreto.
    """
    usuario_id = request.GET.get('usuario')
    juego_id = request.GET.get('juego')

    if not usuario_id or not juego_id:
        return JsonResponse(
            {'error': 'Faltan parámetros usuario o juego'},
            status=400
        )

    racha = (
        Racha.objects
        .filter(usuario_id=usuario_id, juego_id=juego_id)
        .values('ultima_respuesta')
        .first()
    )

    return JsonResponse({
        'usuario_id': int(usuario_id),
        'juego_id': int(juego_id),
        'ultima_respuesta': racha['ultima_respuesta'] if racha else None
    })