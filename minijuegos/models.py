from django.db import models

# Create your models here.
class Pista(models.Model):
    id_juego = models.IntegerField(primary_key=True)
    descripcion = models.CharField(max_length=255)
    valor = models.JSONField()  # Django >= 3.1 permite guardar directamente JSON

    class Meta:
        db_table = 'pistas'
        managed = False  # Si la tabla ya existe y no quieres que Django la reescriba

    def __str__(self):
        return f"Juego {self.id_juego}: {self.descripcion}"
