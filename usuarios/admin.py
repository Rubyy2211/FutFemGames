from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import Group
from .models import Usuario

# Register your models here.
@admin.register(Usuario)
class UsuarioAdmin(UserAdmin):
    list_display = ('username', 'email', 'first_name', 'last_name', 'rol', 'is_staff')
    list_editable = ('rol',) 

    def has_module_permission(self, request):
        return request.user.is_authenticated and getattr(request.user, 'rol', None) == 1
        
    # 2. Controla si el usuario puede entrar a ver el listado de logs
    def has_view_permission(self, request, obj=None):
        return request.user.is_authenticated and getattr(request.user, 'rol', None) == 1
    
    # 1. Formulario para editar un usuario existente
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        ('Información Personal', {'fields': ('first_name', 'last_name', 'email')}),
        ('Información Extra', {'fields': ('rol', 'token', 'jugadora_favorita')}),
        ('Estado', {'fields': ('is_active', 'is_staff', 'is_superuser')}),
    )

    # 2. Formulario para CREAR un usuario nuevo (Añadir usuario)
    # Es vital definirlo porque UserAdmin por defecto solo pide username y las dos contraseñas
    add_fieldsets = UserAdmin.add_fieldsets + (
        ('Información Extra', {
            'fields': ('first_name', 'last_name', 'email', 'rol', 'token', 'jugadora_favorita', 'is_active', 'is_staff'),
        }),
    )
    
    list_filter = ('rol', 'is_staff', 'is_active') 
    filter_horizontal = ()
    ordering = ('username',)

    class Media:
            css = {
                'all': ('https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css','/static/futfem/css/custom_admin.css')
            }

# 1. Le decimos a Django: "Olvida el registro por defecto de los Grupos"
try:
    admin.site.unregister(Group)
except admin.sites.NotRegistered:
    pass

# 2. Lo registramos nosotros bajo tus nuevas reglas de Rol
@admin.register(Group)
class GroupAdmin(admin.ModelAdmin):
    # Solo el rol 1 verá la caja "Autenticación y autorización" en el inicio
    def has_module_permission(self, request):
        return request.user.is_authenticated and getattr(request.user, 'rol', None) == 1
        
    # Bloqueo total de seguridad por si intentan entrar escribiendo la URL a mano
    def has_view_permission(self, request, obj=None):
        return request.user.is_authenticated and getattr(request.user, 'rol', None) == 1