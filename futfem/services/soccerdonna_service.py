import requests
from bs4 import BeautifulSoup
from django.utils import timezone
from futfem.models import Jugadora

BASE_URL = "https://www.soccerdonna.de"
HEADERS = {
    "User-Agent": "Mozilla/5.0"
}


# =========================
# UTILIDADES INTERNAS
# =========================

def _parse_market_value_from_soup(soup):
    label = soup.find(
        "td",
        string=lambda t: t and ("Marktwert" in t or "Market value" in t)
    )

    if not label:
        return None

    raw_value = label.find_next("td").get_text(strip=True)

    if raw_value in ["–", ""]:
        return None

    return int(''.join(filter(str.isdigit, raw_value)))


# =========================
# FUNCIONES PÚBLICAS
# =========================

def get_player_urls_from_club(club_url):
    player_urls = []

    resp = requests.get(club_url, headers=HEADERS)
    resp.raise_for_status()

    soup = BeautifulSoup(resp.content, 'html.parser')

    for a in soup.select("table#spieler a.fb"):
        href = a.get("href", "")
        if "/profil/spieler_" in href:
            player_urls.append(BASE_URL + href)

    return player_urls


def obtener_valor_mercado_desde_url(url):
    response = requests.get(url, headers=HEADERS)
    response.raise_for_status()

    soup = BeautifulSoup(response.text, "html.parser")

    name_tag = soup.find("h1")
    name = name_tag.get_text(strip=True) if name_tag else None
    market_value = _parse_market_value_from_soup(soup)

    return {
        "name": name,
        "market_value": market_value
    }

def obtener_altura_y_pie_desde_url(url):
    """
    Extrae la altura (Height) y el pie habil (Foot) de la jugadora desde Soccerdonna
    """
    response = requests.get(url, headers=HEADERS)
    response.raise_for_status()

    soup = BeautifulSoup(response.text, "html.parser")

    # Inicializar valores
    altura = None
    pie_habil = None

    # Buscar etiquetas <td> con "Größe" o "Height" y "Fuß" o "Foot"
    # Nota: Soccerdonna suele tener tabla con <td>Etiqueta</td><td>Valor</td>
    etiquetas = {
        "altura": ["Grösse", "Height"],
        "pie": ["Fuß", "Foot"]
    }

    for label, keys in etiquetas.items():
        td_label = None
        for key in keys:
            td_label = soup.find("td", string=lambda t: t and key in t)
            if td_label:
                break
        if td_label:
            valor = td_label.find_next("td").get_text(strip=True)
            if label == "altura":
                # Convertir a cm si viene con m (ej: 1,70 m)
                if "m" in valor:
                    valor = valor.replace(",", ".").replace("m", "").strip()
                    try:
                        altura = int(float(valor) * 100)
                    except:
                        altura = None
                else:
                    try:
                        altura = int(''.join(filter(str.isdigit, valor)))
                    except:
                        altura = None
            elif label == "pie":
                pie_habil = valor

    return {
        "altura": altura,        # en cm
        "pie_habil": pie_habil   # ej: "rechts", "links" o "right"/"left"
    }

def actualizar_market_values():
    jugadoras = Jugadora.objects.exclude(soccerdonna_url__isnull=True)

    for j in jugadoras:
        try:
            response = requests.get(j.soccerdonna_url, headers=HEADERS)
            response.raise_for_status()

            soup = BeautifulSoup(response.text, "html.parser")
            mv = _parse_market_value_from_soup(soup)

            j.market_value = mv
            j.soccerdonna_last_updated = timezone.now()
            j.save()

        except Exception as e:
            print(f"Error actualizando {j.Nombre}: {e}")