from django.contrib import admin
from django.utils.html import format_html
from django.contrib.admin.models import LogEntry
from .models import (
    JugadoraPosicion, Pais, Jugadora, Trayectoria, Equipo, 
    Liga, JugadoraPais, EquipoTrofeo, Trofeo, Juego,
)

from minijuegos.models import Pista 

# ==========================================
# 1. CONTROL DE LOGS Y HISTORIAL (Oculto para colaboradores)
# ==========================================
@admin.register(LogEntry)
class LogEntryAdmin(admin.ModelAdmin):
    list_display = ('action_time', 'user', 'content_type', 'object_repr', 'action_flag')
    list_filter = ('user', 'action_flag', 'content_type')
    search_fields = ('object_repr', 'change_message')
    
    def has_module_permission(self, request): return request.user.is_superuser
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
        css = {'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css',)}


@admin.register(Jugadora)
class JugadoraAdmin(admin.ModelAdmin):
    # Una lista súper limpia con foto de perfil grande, banderas y valores de mercado
    list_display = ('ver_foto', 'Nombre', 'Apellidos', 'Apodo', 'ver_nacionalidades', 'market_value_format')
    list_display_links = ('ver_foto', 'Nombre', 'Apellidos')
    
    # Filtros laterales claros con nombres descriptivos indirectos gracias a Django
    list_filter = (
        'retiro',
        'jugadorapais__pais', 
        'jugadoraposicion__posicion',
        ('trayectoria__equipo', admin.RelatedOnlyFieldListFilter),
    )
    search_fields = ('Nombre', 'Apellidos', 'Apodo')
    readonly_fields = ('foto_perfil_bloque',)
    
    # Agrupar campos para que parezca un perfil deportivo real
    fieldsets = (
        ('👤 Ficha de Identidad y Perfil' , {
            'fields': (
                ('Nombre', 'Apellidos', 'Apodo'),
                ('Nacimiento', 'altura', 'pie_habil'),
                ('imagen', 'retiro'),
            ),
            #'description': 'Información básica, datos físicos y estado de actividad de la jugadora.'
            'classes': ('bloque-campos-perfil',),
        }),
        ('💰 Mercado y Enlaces Externos', {
            'fields': ('market_value', 'soccerdonna_url', 'soccerdonna_last_updated'),
            'description': 'Actualización automática y URLs de scouting.'
        }),
    )
    inlines = [NacionalidadInline, PosicionInline, TrayectoriaInline]

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
    list_display = ('ver_escudo', 'nombre', 'ver_logo_liga', 'ver_color')
    list_filter = ('liga',)
    ordering = ('nombre',)
    search_fields = ('nombre',) # Esto permite que funcione el autocomplete_fields desde TrayectoriaInline
    autocomplete_fields = ['equipo_sucesor']
    inlines = [EquipoTrofeoInline]
    
    fieldsets = (
        ('🛡️ Datos del Club', {
            'fields': (('nombre', 'liga'), ('escudo', 'equipo_sucesor'))
        }),
        ('🎨 Identidad Visual y Mapa', {
            'fields': ('color', ('latitud', 'longitud')),
            'description': 'El color se aplicará dinámicamente como fondo de su cromo en la web.'
        }),
    )

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
    list_display = ('ver_logo', 'nombre', 'ver_pais')
    search_fields = ('nombre',)
    list_filter = ('pais',)

    def ver_logo(self, obj):
        if obj.logo:
            return format_html('<img src="/{}" width="45" height="45" style="object-fit: contain;" />', obj.logo)
        return "League Logo"
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
        css = {'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css',)}


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