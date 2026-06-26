import os
from django.contrib import admin
from django.utils.html import format_html
from django import forms
from django.conf import settings
from django.contrib.admin.models import LogEntry
from django.core.files.storage import default_storage
from .models import (
    JugadoraPosicion, Pais, Jugadora, Trayectoria, Equipo, 
    Liga, JugadoraPais, EquipoTrofeo, Trofeo, Juego,
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
    # Enlazamos nuestro formulario personalizado
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
    
    # Añadimos el nuevo campo 'subir_nueva_foto' dentro de los fields
    fieldsets = (
        ('👤 Ficha de Identidad y Perfil' , {
            'fields': (
                ('Nombre', 'Apellidos', 'Apodo'),
                ('Nacimiento', 'altura', 'pie_habil'),
                ('imagen', 'subir_nueva_foto'), # <-- Quedan emparejados: texto a la izquierda, subida a la derecha
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

    # --- EL MOTOR: Procesamos la subida física usando la ruta del cuadro de texto ---
    def save_model(self, request, obj, form, change):
        # 1. Comprobamos si se seleccionó un archivo en el campo virtual
        archivo_subido = form.cleaned_data.get('subir_nueva_foto')
        
        if archivo_subido:
            # Si el usuario modificó o escribió una ruta en el campo 'imagen' (ej: media/ES/jugadoras/cardona.webp)
            ruta_destino_texto = form.cleaned_data.get('imagen')
            
            if not ruta_destino_texto:
                # Si dejó el campo de texto vacío, autogeneramos uno por defecto para que no falle
                ruta_destino_texto = f"media/ES/jugadoras/{archivo_subido.name}"
                obj.imagen = ruta_destino_texto

            # Construimos la ruta absoluta en el disco del servidor (futfem/media/ES/jugadoras/cardona.webp)
            ruta_absoluta = os.path.join(settings.BASE_DIR, 'futfem', ruta_destino_texto.lstrip('/'))
            
            # Creamos las carpetas físicas si no existen
            os.makedirs(os.path.dirname(ruta_absoluta), exist_ok=True)
            
            # Guardamos el archivo binario exactamente en la ruta indicada por texto
            with open(ruta_absoluta, 'wb+') as destination:
                for chunk in archivo_subido.chunks():
                    destination.write(chunk)
                    
        super().save_model(request, obj, form, change)

    # --- VISTAS Y PREVISUALIZACIONES ---
    def foto_perfil_bloque(self, obj):
        if obj and obj.imagen:
            path = obj.imagen if obj.imagen.startswith('http') else f"/{obj.imagen}"
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
            path = obj.imagen if obj.imagen.startswith('http') else f"/{obj.imagen}"
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
    search_fields = ('nombre',) # Esto permite que funcione el autocomplete_fields desde TrayectoriaInline
    autocomplete_fields = ['equipo_sucesor']
    inlines = [EquipoTrofeoInline]
    
    fieldsets = (
        ('🛡️ Datos del Club', {
            'fields': (('nombre', 'liga'), ('escudo', 'subir_nuevo_escudo'), 'equipo_sucesor')
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
            if not ruta_destino_texto:
                # Si el campo de texto está vacío, autogeneramos una ruta razonable basándose en la Liga o por defecto
                iso_liga = obj.liga.pais.iso.upper() if (obj.liga and obj.liga.pais) else 'ES'
                ruta_destino_texto = f"media/{iso_liga}/clubes/{archivo_subido.name}"
                obj.escudo = ruta_destino_texto

            ruta_absoluta = os.path.join(settings.BASE_DIR, 'futfem', ruta_destino_texto.lstrip('/'))
            os.makedirs(os.path.dirname(ruta_absoluta), exist_ok=True)
            
            with open(ruta_absoluta, 'wb+') as destination:
                for chunk in archivo_subido.chunks():
                    destination.write(chunk)
                    
        super().save_model(request, obj, form, change)

    def ver_escudo(self, obj):
        if obj.escudo:
            return format_html('<img src="/{}" width="40" height="40" style="object-fit: contain; background: #fafafa; padding: 2px; border-radius: 6px; border: 1px solid #eee;" />', obj.escudo)
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

    def save_model(self, request, obj, form, change):
        archivo_subido = form.cleaned_data.get('subir_nuevo_logo')
        if archivo_subido:
            ruta_destino_texto = form.cleaned_data.get('logo')
            if not ruta_destino_texto:
                iso_pais = obj.pais.iso.upper() if obj.pais else 'GLOBAL'
                ruta_destino_texto = f"media/{iso_pais}/ligas/{archivo_subido.name}"
                obj.logo = ruta_destino_texto

            ruta_absoluta = os.path.join(settings.BASE_DIR, 'futfem', ruta_destino_texto.lstrip('/'))
            os.makedirs(os.path.dirname(ruta_absoluta), exist_ok=True)
            
            with open(ruta_absoluta, 'wb+') as destination:
                for chunk in archivo_subido.chunks():
                    destination.write(chunk)
                    
        super().save_model(request, obj, form, change)

    def ver_logo(self, obj):
        if obj.logo:
            return format_html('<img src="/{}" width="45" height="45" style="object-fit: contain;" />', obj.logo)
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
        css = {'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css', '/static/futfem/css/custom_admin.css')}


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