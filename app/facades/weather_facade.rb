class WeatherFacade
  def self.get_forecast(location)
    coordinates = get_coordinates(location)
    response = ForecastService.forecast(coordinates)
    Forecast.new(response)
  end

  def self.get_coordinates(location)
    response = LocationService.coordinates(location)
    coordinates = response[:results][0][:locations][0][:latLng]
    # Forecast.new(coordinates)
  end
end
