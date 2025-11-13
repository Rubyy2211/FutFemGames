from django.urls import path
from . import views

urlpatterns = [    
    path('jugadoraxnombre', views.jugadoraxnombre, name='jugadoraxnombre'),
    path('jugadora_trayectoria', views.jugadora_trayectoria, name='jugadora_trayectoria'),
]