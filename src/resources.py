from robot.libraries.BuiltIn import BuiltIn

def Set_Geolocation(latitude, longitude, accuracy=100):
    map_coordinates = {
        "latitude": float(latitude),
        "longitude": float(longitude),
        "accuracy": int(accuracy),
    }
    selib = BuiltIn().get_library_instance("SeleniumLibrary")
    selib.driver.execute_cdp_cmd("Emulation.setGeolocationOverride", map_coordinates)