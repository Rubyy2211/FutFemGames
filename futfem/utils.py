# futfem/utils.py
import cloudinary.utils

def construir_url_imagen(raw_path):
    """
    Recibe una ruta de imagen (relativa o absoluta) de la BD 
    y devuelve la URL pública completa de Cloudinary.
    """
    if not raw_path:
        return None
        
    # Extraer el string si es un FieldFile de Django o convertir a string
    path_str = getattr(raw_path, 'name', str(raw_path)).strip()
    
    if not path_str or path_str == 'None':
        return None
        
    # Si ya es una URL completa (http/https), la devolvemos tal cual
    if path_str.startswith('http://') or path_str.startswith('https://'):
        return path_str

    # Limpiar barra inicial si existe (/jugadoras/foto -> jugadoras/foto)
    if path_str.startswith('/'):
        path_str = path_str[1:]

    # Generar la URL pública en Cloudinary
    url, _ = cloudinary.utils.cloudinary_url(
        path_str,
        secure=True  # Forzar https://
    )
    
    return url

def formatear_valor_mercado(valor):
    """
    Formatea un valor numérico a formato legible de mercado:
    - 1500000 -> "1.5M €"
    - 1000000 -> "1M €"
    - 250000  -> "250k €"
    - 500     -> "500 €"
    """
    if valor is None:
        return 'N/A'
    
    try:
        num = float(valor)
    except (ValueError, TypeError):
        return 'N/A'

    if num <= 0:
        return 'N/A'

    if num >= 1_000_000:
        val = num / 1_000_000
        return f"{val:.0f}M €" if num % 1_000_000 == 0 else f"{val:.1f}M €"
    elif num >= 1_000:
        val = num / 1_000
        return f"{val:.0f}k €" if num % 1_000 == 0 else f"{val:.1f}k €"
    
    return f"{int(num)} €" if num.is_integer() else f"{num} €"