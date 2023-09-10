module Config

version = "1.0.1"
base_url = "https://api.solcast.com.au/data"
live_radiation_and_weather = "/live/radiation_and_weather"
live_rooftop_pv_power = "/live/rooftop_pv_power"
live_advanced_pv_power = "/live/advanced_pv_power"
historic_radiation_and_weather = "/historic/radiation_and_weather"
historic_rooftop_pv_power = "/historic/rooftop_pv_power"
forecast_radiation_and_weather = "/forecast/radiation_and_weather"
forecast_rooftop_pv_power = "/forecast/rooftop_pv_power"
forecast_advanced_pv_power = "/forecast/advanced_pv_power"
tmy_radiation_and_weather = "/tmy/radiation_and_weather"
tmy_rooftop_pv_power = "/tmy/rooftop_pv_power"

export version, base_url, live_radiation_and_weather, live_rooftop_pv_power, live_advanced_pv_power, historic_radiation_and_weather, historic_rooftop_pv_power, forecast_radiation_and_weather, forecast_rooftop_pv_power, forecast_advanced_pv_power, tmy_radiation_and_weather, tmy_rooftop_pv_power

end # module Config