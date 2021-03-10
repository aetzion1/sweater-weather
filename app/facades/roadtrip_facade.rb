class RoadtripFacade
  class << self
    def get_roadtrip(origin, destination)
      start_city = get_city_state(origin)
      end_city = get_city_state(destination)

      formatted_time = TravelService.travel_time(origin, destination)
      travel_time = time_to_string(formatted_time)

      coordinates = get_coordinates(destination)
      
      if formatted_time == "impossible"
        weather_at_eta == {}
      else
        forecast_at_eta = ForecastService.future_forecast(coordinates, formatted_time)
        weather_at_eta = RoadtripForecast.new(forecast_at_eta)
      end

      Roadtrip.new(start_city, end_city, travel_time, weather_at_eta)
    end

    private
    
    def get_coordinates(destination)
      response = LocationService.coordinates(destination)
      response[:results][0][:locations][0][:latLng]
    end

    def get_city_state(location)
      response = LocationService.coordinates(location)
      city = response[:results][0][:locations][0][:adminArea5]
      state = response[:results][0][:locations][0][:adminArea3]
      "#{city}, #{state}"
    end

    def time_to_string(formatted_time)
      return formatted_time if formatted_time == "impossible"
      # minutes = seconds / 60
      # hours = minutes / 60
      # remainder = minutes % 60
      hours = formatted_time[0..1].to_i
      minutes = formatted_time[3..4].to_i
      return "#{hours} hours, #{minutes} minutes" if hours.positive?
      "#{minutes} minutes"
    end
  end
end
