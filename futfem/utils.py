# futfem/utils.py
import cloudinary.utils

def construir_url_imagen(raw_path):
    """
    Recibe una ruta de imagen (relativa o absoluta) de la BD 
    y devuelve la URL pública completa.
    """
    if not raw_path:
        return None
        
    # Si ya es una URL completa (http/https), la dejamos tal cual
    if str(raw_path).startswith('http'):
        return raw_path
        
    # Si es una ruta relativa, le aplicamos el dominio de Cloudinary
    url, _ = cloudinary.utils.cloudinary_url(raw_path)
    return url