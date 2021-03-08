class MunchiesFacade
  class << self
    def get_recommendation(start, destination, food)
      destination_city = get_destination_city(destination)

      travel_time = travel_time(start, destination)

      coordinates = get_coordinates(destination)
      response = ForecastService.forecast(coordinates)
      summary_forecast = MunchiesForecast.new(response[:current])

      restaurant_data = RestaurantService.get_restaurant(food, coordinates)
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

    # MOVE TO SERVICE IF TIME ALLOWS
    def travel_time(start, destination)
      response = map_quest_conn.get('route') do |req|
        req.params[:from] = start
        req.params[:to] = destination
      end

      data = JSON.parse(response.body, symbolize_names: true)
      seconds = data[:route][:realTime]
      minutes = seconds / 60
      hours = minutes / 60
      remainder = minutes % 60
      
      return "#{hours} hours #{remainder} min" if hours.positive?
      "#{minutes} min"
    end

    def map_quest_conn
      Faraday.new(
        url: 'http://www.mapquestapi.com/directions/v2/',
        params: { key: ENV['MAPQUEST_GEOCODING_API_KEY'] }
      )
    end
  end
end
