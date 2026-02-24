from django.contrib import admin
from django.contrib import admin
from django.utils.html import format_html
from .models import Jugadora, Trayectoria, Equipo, Liga
# Register your models here.

# 1. Definimos el Inline para la Trayectoria
class TrayectoriaInline(admin.TabularInline):
    model = Trayectoria
    extra = 1  # Número de filas vacías para añadir nuevos equipos
    fields = ('equipo', 'años', 'equipo_actual', 'ver_escudo')
    readonly_fields = ('ver_escudo',)
    
    def ver_escudo(self, obj):
        if obj.equipo and obj.equipo.escudo:
            # Usamos la ruta / porque tu campo imagen suele ser un TextField con la ruta
            return format_html('<img src="/{}" width="30" height="30" />', obj.equipo.escudo)
        return ""
    ver_escudo.short_description = "Escudo"

# 2. Registramos la Jugadora con su configuración
@admin.register(Jugadora)
class JugadoraAdmin(admin.ModelAdmin):
    # Columnas en la lista principal
    list_display = ('ver_foto', 'Nombre', 'Apellidos', 'Nacionalidad', 'Posicion', 'market_value')
    list_filter = ('Nacionalidad', 'Posicion', 'retiro')
    search_fields = ('Nombre', 'Apellidos', 'Apodo')
    
    # Organización del formulario de edición
    fieldsets = (
        ('Información Personal', {
            'fields': (('Nombre', 'Apellidos'), 'Apodo', 'Nacimiento', 'Nacionalidad')
        }),
        ('Datos Deportivos', {
            'fields': ('Posicion', 'altura', 'pie_habil', 'retiro')
        }),
        ('Imagen y Enlaces', {
            'fields': ('imagen', 'soccerdonna_url', 'market_value', 'soccerdonna_last_updated')
        }),
    )

    # Añadimos la Trayectoria al formulario de la Jugadora
    inlines = [TrayectoriaInline]

    def ver_foto(self, obj):
        if obj.imagen:
            return format_html('<img src="/{}" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" />', obj.imagen)
        return "No foto"
    ver_foto.short_description = 'Foto'

    # Corrección del __str__ en tu modelo
    # Nota: En tu modelo pusiste return self.Jugadora, pero el campo es self.Nombre

@admin.register(Equipo)
class EquipoAdmin(admin.ModelAdmin):
    list_display = ('ver_escudo', 'nombre', 'ver_logo_liga', 'ver_color', 'latitud', 'longitud')
    list_filter = ('liga',)
    search_fields = ('nombre',)
    
    # Organizar el formulario por secciones
    fieldsets = (
        ('Información Básica', {
            'fields': ('nombre', 'liga', 'escudo')
        }),
        ('Identidad y Ubicación', {
            'fields': ('color', ('latitud', 'longitud'))
        }),
    )

    def ver_escudo(self, obj):
        if obj.escudo:
            # Como indicas que 'escudo' ya es la URL propia, la usamos directamente
            return format_html('<img src="/{}" width="35" height="35" style="object-fit: contain;" />', obj.escudo)
        return "No logo"
    ver_escudo.short_description = 'Escudo'

    def ver_logo_liga(self, obj):
        if obj.liga and obj.liga.logo:
            # Detectamos si es una URL completa o una ruta relativa
            url = obj.liga.logo.url if hasattr(obj.liga.logo, 'url') else f"/{obj.liga.logo}"
            return format_html(
                '<div style="display:flex; align-items:center; gap:5px;">'
                '<img src="{}" width="25" height="25" style="object-fit:contain;">'
                '<span>{}</span></div>', 
                url, obj.liga.nombre
            )
        return obj.liga.nombre if obj.liga else "-"
    ver_logo_liga.short_description = 'Liga'

    def ver_color(self, obj):
        if obj.color:
            return format_html(
                '<div style="display: flex; align-items: center; gap: 8px;">'
                '<div style="width: 20px; height: 20px; background-color: {}; border: 1px solid #ccc; border-radius: 3px;"></div>'
                '<span>{}</span></div>',
                obj.color, obj.color
            )
        return "Sin color"
    ver_color.short_description = 'Color Principal'

@admin.register(Liga)
class LigaAdmin(admin.ModelAdmin):
    # Vista de lista: Nombre, Bandera del País y Logo de la Liga
    list_display = ('ver_logo', 'nombre', 'ver_pais')
    search_fields = ('nombre',) # NECESARIO para que aparezca en el autocomplete de Equipo
    list_filter = ('pais',)

    def ver_logo(self, obj):
        if obj.logo:
            # Si el logo es una URL directa (TextField)
            return format_html('<img src="/{}" width="40" height="40" style="object-fit: contain;" />', obj.logo)
        return "Sin logo"
    ver_logo.short_description = 'Logo'

    def ver_pais(self, obj):
        if obj.pais:
            # Usando la librería de banderas que cargamos antes en PistaAdmin
            return format_html(
                '<span class="fi fi-{}" style="margin-right: 8px;"></span> {}',
                obj.pais.iso.lower(),
                obj.pais.nombre
            )
        return "-"
    ver_pais.short_description = 'País'

    # Cargamos los iconos de banderas también aquí
    class Media:
        css = {
            'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css',)
        }