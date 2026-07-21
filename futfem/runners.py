from django.test.runner import DiscoverRunner
from django.apps import apps

class UnmanagedModelsTestRunner(DiscoverRunner):
    """
    Runner personalizado para forzar a Django a crear las tablas 
    con 'managed = False' en la base de datos de pruebas.
    """
    def setup_databases(self, **kwargs):
        for model in apps.get_models():
            model._meta.managed = True
        return super().setup_databases(**kwargs)