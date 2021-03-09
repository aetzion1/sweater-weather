class RoadTripFacade
  class << self
    def get_roadtrip(origin, destination)
      start_city = get_city_state(origin)
      end_city = get_city_state(destination)

      seconds = TravelService.travel_time(origin, destination)
      travel_time = time_to_string(seconds)

      coordinates = get_coordinates(destination)
      response = ForecastService.forecast(coordinates)
      weather_at_eta = RoadTripForecast.new(response[:current])

      arrival_time = Time.at(((Time.now + seconds).to_r / (30*60)).round * (30*60))
      # travel_data = TravelService.get_travel(food, coordinates, arrival_time)
      # Travel = Travel.new(travel_data)

      RoadTrip.new(start_city, end_city, travel_time, weather_at_eta)
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

    def time_to_string(seconds)
      minutes = seconds / 60
      hours = minutes / 60
      remainder = minutes % 60
      
      return "#{hours} hours, #{remainder} minutes" if hours.positive?
      "#{minutes} minutes"
    end
  end
end
