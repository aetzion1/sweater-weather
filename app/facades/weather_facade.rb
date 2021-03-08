class WeatherFacade
  def self.get_forecast(location)
    coordinates = get_coordinates(location)
    response = ForecastService.forecast(coordinates)
    current_weather = CurrentWeather.new(response[:current])
    daily_weather = response[:daily].first(5).map do |day|
      DailyWeather.new(day)
    end
    hourly_weather = response[:hourly].first(8).map do |hour|
      HourlyWeather.new(hour)
    end
    Forecast.new(current_weather, daily_weather, hourly_weather)
  end

  def self.get_coordinates(location)
    response = LocationService.coordinates(location)
    coordinates = response[:results][0][:locations][0][:latLng]
    coordinates != { lat: 39.390897, lng: -99.066067 } ? coordinates : nil
  end
end
