from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver

def Set_Geolocation(latitude, longitude, accuracy=100):
    map_coordinates = {
        "latitude": float(latitude),
        "longitude": float(longitude),
        "accuracy": int(accuracy),
    }
    selib = BuiltIn().get_library_instance("SeleniumLibrary")
    selib.driver.execute_cdp_cmd("Emulation.setGeolocationOverride", map_coordinates)

def get_firefox_geolocation_capabilities(latitude, longitude):
    # 1. Cria uma instância vazia de opções do Firefox
    options = webdriver.FirefoxOptions()
    
    # 2. Define todas as preferências de geolocalização necessárias
    options.set_preference("geo.enabled", True)
    options.set_preference("permissions.default.geo", 1) # 1 = Permitir automaticamente
    options.set_preference("geo.prompt.testing", True)
    options.set_preference("geo.prompt.testing.allow", True)
    options.set_preference("geo.provider.network.url",
                         f"data:application/json,{{\"location\": {{\"lat\": {float(latitude)}, \"lng\": {float(longitude)}}}, \"accuracy\": 100.0}}")
    
    # 3. Converte o objeto de opções em um dicionário que o 'Open Browser' entende e o retorna
    return options