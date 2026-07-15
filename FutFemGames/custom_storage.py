# FutFemGames/custom_storage.py
import os
import cloudinary.uploader
from cloudinary_storage.storage import MediaCloudinaryStorage

class CustomMediaCloudinaryStorage(MediaCloudinaryStorage):
    def _upload(self, name, content):
        # Sobrescribimos los parámetros de subida para apagar el sufijo único
        options = {
            'use_filename': True,
            'unique_filename': False,
            'resource_type': self._get_resource_type(name),
            'tags': self.TAG
        }
        folder = os.path.dirname(name)
        if folder:
            options['folder'] = folder
            
        return cloudinary.uploader.upload(content, **options)