from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('minigames', views.minijuegos, name='minijuegos'),
    path('loading', views.loading),
    path('nosotros', views.nosotros, name='nosotros'),
    path('minigames/career', views.futfemTrajectory),
    path('minigames/grid', views.futfemGrid),
    path('minigames/bingo', views.futfemBingo),
    path('minigames/wordle', views.futfemWordle),
    path('minigames/mates', views.futfemMates),
    path('minigames/guess', views.futfemGuess),
    path('minigames/higher_lower', views.futfemHigherLower, name='higher_lower'),
    path('api/juegoxid', views.juegoxid, name='juegoxid'),
    path('XI_Clubs', views.futfemXIClubs, name='futfemXIClubs'),
]