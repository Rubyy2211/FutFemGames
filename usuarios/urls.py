from django.urls import path
from . import views

urlpatterns = [
    path('accounts/login/', views.login_view, name='login'),
    path('accounts/logout/', views.logout_view, name='logout'),
    path('accounts/registro/', views.registro_view, name='registro'),
    path('accounts/sesion/', views.sesion_view, name='sesion'),
    path('accounts/perfil/', views.perfil_view, name='perfil'),
    path('accounts/racha/', views.obtener_rachas, name='racha'),
    path('accounts/juego_racha/', views.juego_racha, name='juego_racha'),
    path('accounts/ultima_respuesta/', views.obtener_ultima_respuesta, name='ultima_respuesta')
 ]