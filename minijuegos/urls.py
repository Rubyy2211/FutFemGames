from django.urls import path
from . import views

urlpatterns = [
    path('', views.index),
    path('loading', views.loading),
    path('career', views.futfemTrajectory),
    path('api/juegoxid', views.juegoxid, name='juegoxid')
]