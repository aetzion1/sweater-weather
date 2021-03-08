class MunchiesFacade
  class << self
    def get_recommendation(start, destination, food)
      destination_city = get_destination_city(destination)

      seconds = RestaurantService.travel_time(start, destination)
      travel_time = time_to_string(seconds)

      coordinates = get_coordinates(destination)
      response = ForecastService.forecast(coordinates)
      summary_forecast = MunchiesForecast.new(response[:current])

      arrival_time = Time.at(((Time.now + seconds).to_r / (30*60)).round * (30*60))
      restaurant_data = RestaurantService.get_restaurant(food, coordinates, arrival_time)
      restaurant = Restaurant.new(restaurant_data)

      Munchies.new(destination_city, travel_time, summary_forecast, restaurant)
    end

    private
    
    def get_coordinates(destination)
      response = LocationService.coordinates(destination)
      response[:results][0][:locations][0][:latLng]
    end

    def get_destination_city(destination)
      response = LocationService.coordinates(destination)
      city = response[:results][0][:locations][0][:adminArea5]
      state = response[:results][0][:locations][0][:adminArea3]
      "#{city}, #{state}"
    end

    def time_to_string(seconds)
      minutes = seconds / 60
      hours = minutes / 60
      remainder = minutes % 60
      
      return "#{hours} hours #{remainder} min" if hours.positive?
      "#{minutes} min"
    end
  end
end
