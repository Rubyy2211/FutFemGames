import os
from django.contrib import admin
from django.utils.html import format_html
import cloudinary.uploader
from django import forms
from django.conf import settings
from django.contrib import messages
from django.contrib.admin.models import LogEntry
from django.core.files.storage import default_storage
from .models import (
    JugadoraPosicion, Pais, Jugadora, Trayectoria, Equipo, 
    Liga, JugadoraPais, EquipoTrofeo, Trofeo, Juego, Formacion, EquipoFormacion
)

from minijuegos.models import Pista 

# ==========================================
# 📋 FORMULARIOS PERSONALIZADOS (CAMPOS VIRTUALES)
# ==========================================

class JugadoraAdminForm(forms.ModelForm):
    subir_nueva_foto = forms.ImageField(
        required=False,
        label="📁 Subir archivo físico",
        help_text="Selecciona una foto para subirla directamente a la ruta indicada en el campo 'Imagen'."
    )
    class Meta:
        model = Jugadora
        fields = '__all__'

class EquipoAdminForm(forms.ModelForm):
    subir_nuevo_escudo = forms.ImageField(
        required=False,
        label="📁 Subir escudo físico",
        help_text="Selecciona una imagen para subirla directamente a la ruta indicada en el campo 'Escudo'."
    )
    class Meta:
        model = Equipo
        fields = '__all__'

class LigaAdminForm(forms.ModelForm):
    subir_nuevo_logo = forms.ImageField(
        required=False,
        label="📁 Subir logo físico",
        help_text="Selecciona una imagen para subirla directamente a la ruta indicada en el campo 'Logo'."
    )
    class Meta:
        model = Liga
        fields = '__all__'
# ==========================================
# 1. CONTROL DE LOGS Y HISTORIAL (Oculto para colaboradores)
# ==========================================
@admin.register(LogEntry)
class LogEntryAdmin(admin.ModelAdmin):
    list_display = ('action_time', 'user', 'content_type', 'object_repr', 'action_flag')
    list_filter = ('user', 'action_flag', 'content_type')
    search_fields = ('object_repr', 'change_message')
    
    # 1. Controla si el modelo aparece en la página principal del admin
    def has_module_permission(self, request):
        return request.user.is_authenticated and getattr(request.user, 'rol', None) == 1
        
    # 2. Controla si el usuario puede entrar a ver el listado de logs
    def has_view_permission(self, request, obj=None):
        return request.user.is_authenticated and getattr(request.user, 'rol', None) == 1
        
    # Bloqueo total de acciones (Lectura pura)
    def has_add_permission(self, request): return False
    def has_change_permission(self, request, obj=None): return False
    def has_delete_permission(self, request, obj=None): return False


# ==========================================
# 2. INLINES VISUALES (Tablas dinámicas dentro de fichas)
# ==========================================
class TrayectoriaInline(admin.TabularInline):
    model = Trayectoria
    extra = 1
    verbose_name = "📍 Equipo en su Carrera"
    verbose_name_plural = "📊 Historial de Equipos (Trayectoria)"
    fields = ('equipo', 'ver_escudo', 'fecha_inicio', 'fecha_fin', 'equipo_actual')
    readonly_fields = ('ver_escudo',)
    ordering = ('-fecha_inicio',)
    autocomplete_fields = ['equipo']  # Buscador predictivo en vez de un desplegable infinito

    def ver_escudo(self, obj):
        if obj.equipo and obj.equipo.escudo:
            return format_html('<img src="/{}" style="height: 35px; width: 35px; object-fit: contain;" />', obj.equipo.escudo)
        return "⚠️ Sin escudo"
    ver_escudo.short_description = "Escudo"


class NacionalidadInline(admin.TabularInline):
    model = JugadoraPais
    extra = 1
    verbose_name = "🌍 Nacionalidad"
    verbose_name_plural = "🌍 Países / Pasaportes"
    fields = ('pais', 'ver_bandera', 'es_primaria')
    readonly_fields = ('ver_bandera',)
    autocomplete_fields = ['pais']

    def ver_bandera(self, obj):
        if obj.pais and obj.pais.iso:
            return format_html('<span class="fi fi-{}" style="font-size: 1.3em;"></span>', obj.pais.iso.lower())
        return ""
    ver_bandera.short_description = "Ver"


class PosicionInline(admin.TabularInline):
    model = JugadoraPosicion
    extra = 1
    verbose_name = "🏃‍♀️ Demarcación"
    verbose_name_plural = "🏃‍♀️ Posiciones en el Campo"
    fields = ('posicion', 'es_primaria')


class EquipoTrofeoInline(admin.TabularInline):
    model = EquipoTrofeo
    extra = 1
    verbose_name = "🏆 Título Conquistado"
    verbose_name_plural = "🏆 Vitrina de Trofeos (Palmarés)"
    fields = ('trofeo', 'temporada')
    autocomplete_fields = ['trofeo']

    def get_queryset(self, request):
        return super().get_queryset(request).select_related('trofeo')

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "trofeo":
            kwargs["queryset"] = Trofeo.objects.filter(tipo='clubes')
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

class EquipoFormacionInline(admin.TabularInline):
    model = EquipoFormacion
    extra = 1 # Muestra 1 fila vacía por defecto para añadir rápido
    fields = ('formacion', 'temporada', 'es_principal')
    # Si la lista de formaciones es muy larga, puedes habilitar autocomplete:
    # autocomplete_fields = ['formacion']

# ==========================================
# 3. ENTIDADES DE FÚTBOL FEMENINO
# ==========================================
@admin.register(Trofeo)
class TrofeoAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'tipo')
    search_fields = ('nombre',)
    list_filter = ('tipo',)
    class Media:
        css = {'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css', '/static/futfem/css/custom_admin.css', '/static/futfem/css/admin_jugadora.css')}


@admin.register(Pais)
class PaisAdmin(admin.ModelAdmin):
    list_display = ('ver_bandera', 'nombre', 'iso')
    search_fields = ('nombre', 'iso')
    ordering = ('nombre',)
    # Habilitar autocomplete_fields para que sea indexable desde los Inlines
    search_fields = ['nombre', 'iso'] 

    def ver_bandera(self, obj):
        if obj.iso:
            return format_html('<span class="fi fi-{}" style="font-size: 1.8em; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.2);"></span>', obj.iso.lower())
        return "🏳️"
    ver_bandera.short_description = 'Bandera'

    class Media:
        css = {'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css', '/static/futfem/css/custom_admin.css')}


@admin.register(Jugadora)
class JugadoraAdmin(admin.ModelAdmin):
    form = JugadoraAdminForm

    list_display = ('ver_foto', 'Nombre', 'Apellidos', 'Apodo', 'ver_nacionalidades', 'market_value_format')
    list_display_links = ('ver_foto', 'Nombre', 'Apellidos')
    
    list_filter = (
        'retiro',
        'jugadorapais__pais', 
        'jugadoraposicion__posicion',
        ('trayectoria__equipo', admin.RelatedOnlyFieldListFilter),
    )
    search_fields = ('Nombre', 'Apellidos', 'Apodo')
    readonly_fields = ('foto_perfil_bloque',)
    
    fieldsets = (
        ('👤 Ficha de Identidad y Perfil' , {
            'fields': (
                ('Nombre', 'Apellidos', 'Apodo'),
                ('Nacimiento', 'altura', 'pie_habil'),
                ('imagen', 'subir_nueva_foto'),
                'retiro',
            ),
            'classes': ('bloque-campos-perfil',),
        }),
        ('💰 Mercado y Enlaces Externos', {
            'fields': ('market_value', 'soccerdonna_url', 'soccerdonna_last_updated'),
            'description': 'Actualización automática y URLs de scouting.'
        }),
    )
    inlines = [NacionalidadInline, PosicionInline, TrayectoriaInline]

    # --- MÉTODO AUXILIAR: Obtiene el ISO del país principal (Soporta creación y edición) ---
    def obtener_iso_pais_principal(self, request, obj):
        # 1. Si la jugadora ya existe en la BD, buscamos su país principal guardado
        if obj.pk:
            nacionalidad_primaria = obj.jugadorapais_set.filter(es_primaria=True).select_related('pais').first()
            if nacionalidad_primaria and nacionalidad_primaria.pais:
                return nacionalidad_primaria.pais.iso.upper()
        
        # 2. Si es una jugadora nueva (o no tiene país en BD), buscamos en los datos enviados por el formulario (POST)
        # Django organiza los inlines en el POST como 'jugadorapais_set-X-campo'
        prefix = 'jugadorapais_set'
        total_forms_key = f'{prefix}-TOTAL_FORMS'
        
        if total_forms_key in request.POST:
            try:
                total_forms = int(request.POST.get(total_forms_key, 0))
                for i in range(total_forms):
                    # Omitimos si se ha marcado para borrar en el inline
                    delete = request.POST.get(f'{prefix}-{i}-DELETE')
                    if delete:
                        continue
                        
                    es_primaria = request.POST.get(f'{prefix}-{i}-es_primaria')
                    # En Django, si el checkbox de primaria está marcado, viene en el POST como 'on' o 'true'
                    if es_primaria:
                        pais_id = request.POST.get(f'{prefix}-{i}-pais')
                        if pais_id:
                            try:
                                pais = Pais.objects.get(pk=pais_id)
                                return pais.iso.upper()
                            except Pais.DoesNotExist:
                                pass
            except ValueError:
                pass
                
        # 3. Fallback por defecto si no se encuentra ningún país seleccionado
        return 'ES'

    # --- EL MOTOR: Procesamos la subida física usando la ruta y el país principal ---
    def save_model(self, request, obj, form, change):
        archivo_subido = form.cleaned_data.get('subir_nueva_foto')
        
        if archivo_subido:
            ruta_destino_texto = form.cleaned_data.get('imagen')
            
            # Obtenemos el ISO dinámicamente
            iso_pais = self.obtener_iso_pais_principal(request, obj)
            
            # 1. Aplicamos la regla inteligente de rutas
            if not ruta_destino_texto:
                # Si está vacío -> Genera la ruta completa con el nombre del archivo subido
                ruta_destino_texto = f"media/{iso_pais}/jugadoras/{archivo_subido.name}"
            elif '/' not in ruta_destino_texto:
                # Si solo has escrito el nombre de archivo (ej: "asllani.webp") -> Le pega la ruta automáticamente
                ruta_destino_texto = f"media/{iso_pais}/jugadoras/{ruta_destino_texto}"
            
            # 2. Aseguramos que siempre empiece por 'media/'
            ruta_limpia = ruta_destino_texto.lstrip('/')
            if not ruta_limpia.startswith('media/'):
                ruta_limpia = f"media/{ruta_limpia}"
                
            # 3. Desglosamos la ruta para Cloudinary
            # Ej: 'media/SE/jugadoras/asllani.webp' -> folder='media/SE/jugadoras', public_id='asllani'
            folder_path, full_filename = os.path.split(ruta_limpia)
            filename_without_ext, _ = os.path.splitext(full_filename)
            
            try:
                # 4. Subida directa a Cloudinary sin guardar nada local
                cloudinary.uploader.upload(
                    archivo_subido,
                    public_id=filename_without_ext,
                    folder=folder_path,
                    unique_filename=False,  # Mantiene el nombre limpio sin sufijos aleatorios
                    overwrite=True          # Sobrescribe si ya existiera
                )
                
                # 5. Guardamos en la base de datos la ruta formateada
                obj.imagen = ruta_limpia
                
            except Exception as e:
                messages.error(request, f"❌ Error crítico al subir la foto a Cloudinary: {e}")
                return  # Cancela el guardado en la BD si la subida a la nube falla

        super().save_model(request, obj, form, change)

    # --- VISTAS Y PREVISUALIZACIONES ---
    def foto_perfil_bloque(self, obj):
        if obj and obj.imagen:
            path = obj.imagen if obj.imagen.startswith('http') else f"/{obj.imagen.lstrip('/')}"
        else:
            path = "/static/img/predeterm.png"
            
        return format_html(
            '<div class="contenedor-foto-bloque">'
            '<img src="{}" />'
            '</div>', 
            path
        )
    foto_perfil_bloque.short_description = 'Fotografía'

    def ver_foto(self, obj):
        if obj.imagen:
            path = obj.imagen if obj.imagen.startswith('http') else f"/{obj.imagen.lstrip('/')}"
        else:
            path = "/static/img/predeterm.png"
            
        return format_html(
            '<img src="{}" style="width: 50px; height: 50px; border-radius: 12px; object-fit: cover; box-shadow: 0 2px 5px rgba(0,0,0,0.15);" />', 
            path
        )
    ver_foto.short_description = 'Perfil'

    def ver_nacionalidades(self, obj):
        nacionalidades = JugadoraPais.objects.filter(jugadora=obj).select_related('pais')
        if not nacionalidades: return "⚠️ Sin asignar"
            
        html = '<div style="display: flex; gap: 6px; align-items: center;">'
        for n in nacionalidades:
            estilo = "border: 2px solid #264b5d; transform: scale(1.1);" if n.es_primaria else "opacity: 0.5;"
            html += format_html(
                '<span class="fi fi-{}" title="{}" style="{} border-radius: 3px; font-size: 1.2em;"></span>',
                n.pais.iso.lower(),
                f"{n.pais.nombre} ({'Principal' if n.es_primaria else 'Secundaria'})",
                estilo
            )
        html += '</div>'
        return format_html(html)
    ver_nacionalidades.short_description = 'País'

    def market_value_format(self, obj):
        if obj.market_value:
            return f"{obj.market_value:,} €".replace(",", ".")
        return "—"
    market_value_format.short_description = "Valor de Mercado"

    class Media:
        css = {'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css', '/static/futfem/css/custom_admin.css', '/static/futfem/css/admin_jugadora.css')}

@admin.register(Equipo)
class EquipoAdmin(admin.ModelAdmin):
    form = EquipoAdminForm
    list_display = ('ver_escudo', 'nombre', 'ver_logo_liga', 'ver_color')
    list_filter = ('liga',)
    ordering = ('nombre',)
    search_fields = ('nombre',)
    autocomplete_fields = ['equipo_sucesor']
    inlines = []  # Añade tus inlines aquí: [EquipoTrofeoInline, EquipoFormacionInline]
    
    fieldsets = (
        ('🛡️ Datos del Club', {
            'fields': (('nombre', 'liga'), ('escudo', 'subir_nuevo_escudo'), ('fundacion', 'equipo_sucesor'))
        }),
        ('🎨 Identidad Visual y Mapa', {
            'fields': ('color', ('latitud', 'longitud')),
            'description': 'El color se aplicará dinámicamente como fondo de su cromo en la web.'
        }),
    )

    def save_model(self, request, obj, form, change):
        archivo_subido = form.cleaned_data.get('subir_nuevo_escudo')
        
        if archivo_subido:
            ruta_destino_texto = form.cleaned_data.get('escudo')
            
            # 1. Si no ha escrito ruta, la autogeneramos
            if not ruta_destino_texto:
                iso_liga = obj.liga.pais.iso.upper() if (obj.liga and obj.liga.pais) else 'ES'
                ruta_destino_texto = f"media/{iso_liga}/clubes/{archivo_subido.name}"
            
            # 2. Normalizamos la ruta para que siempre empiece por 'media/'
            ruta_limpia = ruta_destino_texto.lstrip('/')
            if not ruta_limpia.startswith('media/'):
                ruta_limpia = f"media/{ruta_limpia}"
            
            # 3. Desglosamos la ruta para Cloudinary
            # Ej: 'media/ES/clubes/barcelona.webp' -> folder='media/ES/clubes', public_id='barcelona'
            folder_path, full_filename = os.path.split(ruta_limpia)
            filename_without_ext, _ = os.path.splitext(full_filename)
            
            try:
                # 4. Subida directa a Cloudinary sin tocar el disco local
                cloudinary.uploader.upload(
                    archivo_subido,
                    public_id=filename_without_ext,
                    folder=folder_path,
                    unique_filename=False,  # 👈 Mantiene el nombre limpio sin sufijos aleatorios
                    overwrite=True          # Sobrescribe si ya existiera
                )
                
                # 5. Guardamos en la base de datos la ruta formateada
                obj.escudo = ruta_limpia
                
            except Exception as e:
                # Si Cloudinary falla (ej. sin conexión), avisamos al admin y cancelamos el guardado del archivo
                messages.error(request, f"❌ Error crítico al subir el escudo a Cloudinary: {e}")
                return  # Detiene la ejecución para no guardar datos inconsistentes

        super().save_model(request, obj, form, change)

    def ver_escudo(self, obj):
        if obj.escudo:
            # Nos aseguramos de que empiece por '/' para que la URL sea relativa a tu dominio
            # y así tu urls.py intercepte el '/media/...' y lo redirija a Cloudinary
            ruta_url = f"/{obj.escudo.lstrip('/')}"
            return format_html('<img src="{}" width="40" height="40" style="object-fit: contain; background: #fafafa; padding: 2px; border-radius: 6px; border: 1px solid #eee;" />', ruta_url)
        return "❌ Sin Escudo"
    ver_escudo.short_description = 'Escudo'

    def ver_logo_liga(self, obj):
        if obj.liga and obj.liga.logo:
            url = obj.liga.logo.url if hasattr(obj.liga.logo, 'url') else f"/{obj.liga.logo}"
            return format_html(
                '<div style="display:flex; align-items:center; gap:8px;">'
                '<img src="{}" width="28" height="28" style="object-fit:contain;">'
                '<span style="font-weight: 500;">{}</span></div>', 
                url, obj.liga.nombre
            )
        return obj.liga.nombre if obj.liga else "—"
    ver_logo_liga.short_description = 'Competición'

    def ver_color(self, obj):
        if obj.color:
            return format_html(
                '<div style="display: flex; align-items: center; gap: 8px;">'
                '<div style="width: 24px; height: 24px; background-color: {}; border: 2px solid #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.2); border-radius: 50%;"></div>'
                '<code style="font-size: 11px;">{}</code></div>',
                obj.color, obj.color
            )
        return "⚠️ No asignado"
    ver_color.short_description = 'Color Principal'

    class Media:
        css = {'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css', '/static/futfem/css/custom_admin.css', '/static/futfem/css/admin_equipo.css')}

@admin.register(Liga)
class LigaAdmin(admin.ModelAdmin):
    form = LigaAdminForm
    list_display = ('ver_logo', 'nombre', 'ver_pais')
    search_fields = ('nombre',)
    list_filter = ('pais',)

    fieldsets = (
        ('🏆 Configuración de la Competición', {
            'fields': ('nombre', 'pais', ('logo', 'subir_nuevo_logo'))
        }),
    )

    # --- EL MOTOR: Procesamos la subida a Cloudinary usando el país de la liga ---
    def save_model(self, request, obj, form, change):
        archivo_subido = form.cleaned_data.get('subir_nuevo_logo')
        
        if archivo_subido:
            ruta_destino_texto = form.cleaned_data.get('logo')
            
            # Obtenemos el ISO del país asignado a la liga (o 'GLOBAL' si no tiene país)
            iso_pais = obj.pais.iso.upper() if obj.pais else 'GLOBAL'
            
            # 1. Aplicamos la regla inteligente de rutas
            if not ruta_destino_texto:
                # Si está vacío -> Genera la ruta completa con el nombre del archivo subido
                ruta_destino_texto = f"media/{iso_pais}/ligas/{archivo_subido.name}"
            elif '/' not in ruta_destino_texto:
                # Si solo has escrito el nombre (ej: "liga_f.webp") -> Le pega la ruta automáticamente
                ruta_destino_texto = f"media/{iso_pais}/ligas/{ruta_destino_texto}"
            
            # 2. Aseguramos que siempre empiece por 'media/' sin barras iniciales duplicadas
            ruta_limpia = ruta_destino_texto.lstrip('/')
            if not ruta_limpia.startswith('media/'):
                ruta_limpia = f"media/{ruta_limpia}"
                
            # 3. Desglosamos la ruta para Cloudinary
            # Ej: 'media/ES/ligas/liga_f.webp' -> folder='media/ES/ligas', public_id='liga_f'
            folder_path, full_filename = os.path.split(ruta_limpia)
            filename_without_ext, _ = os.path.splitext(full_filename)
            
            try:
                # 4. Subida directa a Cloudinary sin guardar nada localmente
                cloudinary.uploader.upload(
                    archivo_subido,
                    public_id=filename_without_ext,
                    folder=folder_path,
                    unique_filename=False,  # Mantiene el nombre limpio sin hashes extraños
                    overwrite=True          # Sobrescribe el logo anterior si tiene el mismo nombre
                )
                
                # 5. Guardamos en la base de datos la ruta formateada para redirección local
                obj.logo = ruta_limpia
                
            except Exception as e:
                # Alerta visual en el admin si falla el servicio o las credenciales de Cloudinary
                messages.error(request, f"❌ Error crítico al subir el logo a Cloudinary: {e}")
                return  # Detiene la operación para proteger la base de datos

        super().save_model(request, obj, form, change)

    # --- VISTAS Y PREVISUALIZACIONES ---
    def ver_logo(self, obj):
        if obj.logo:
            # Aseguramos que empiece por '/' para que la URL sea relativa y funcione con tu redirector
            path = obj.logo if str(obj.logo).startswith('http') else f"/{str(obj.logo).lstrip('/')}"
            return format_html(
                '<img src="{}" width="45" height="45" style="object-fit: contain; background: #fafafa; padding: 3px; border-radius: 8px; border: 1px solid #eee;" />', 
                path
            )
        return "❌ Sin Logo"
    ver_logo.short_description = 'Logo'

    def ver_pais(self, obj):
        if obj.pais:
            return format_html(
                '<div style="display: flex; align-items: center; gap: 6px;">'
                '<span class="fi fi-{}"></span> <span>{}</span></div>',
                obj.pais.iso.lower(), obj.pais.nombre
            )
        return "-"
    ver_pais.short_description = 'País Organizado'

    class Media:
        css = {
            'all': (
                'https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css', 
                '/static/futfem/css/custom_admin.css'
            )
        }

@admin.register(Formacion)
class FormacionAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'descripcion')
    search_fields = ('nombre',)

# ==========================================
# 4. MÓDULO DE SEGURIDAD (Totalmente oculto para no-superusuarios)
# ==========================================
class PistaInline(admin.TabularInline):
    model = Pista
    extra = 1

@admin.register(Juego)
class JuegoAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'slug')
    inlines = [PistaInline]
    def has_module_permission(self, request): return request.user.is_superuser

#@admin.register(Pista)
#class PistaAdmin(admin.ModelAdmin):
#    list_display = ('juego', 'descripcion', 'valor')
#    def has_module_permission(self, request): return request.user.is_superuser