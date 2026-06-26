from django.db import models
from futfem.models import Juego
# Create your models here.


class Pista(models.Model):
    juego = models.ForeignKey(
        Juego, on_delete=models.CASCADE, db_column='id_juego', primary_key=True)
    descripcion = models.TextField()
    valor = models.TextField()

    class Meta:
        db_table = 'pistas'
        managed = False

    def __str__(self):
        return f"Juego {self.juego}: {self.descripcion}"
