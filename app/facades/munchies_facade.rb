class MunchiesFacade
  def self.get_recommendation(start, destination, food)
    destination_city = get_destination_city(destination)

    travel_time = travel_time(start, destination)

    coordinates = get_coordinates(destination)
    response = ForecastService.forecast(coordinates)
    summary_forecast = MunchiesForecast.new(response[:current])

    restaurant_data = RestaurantService.get_restaurant(food, coordinates)
    restaurant = Restaurant.new(restaurant_data)

    Munchies.new(destination_city, travel_time, summary_forecast, restaurant)
  end
  
  def self.get_coordinates(destination)
    response = LocationService.coordinates(destination)
    response[:results][0][:locations][0][:latLng]
  end

  def self.get_destination_city(destination)
    response = LocationService.coordinates(destination)
    city = response[:results][0][:locations][0][:adminArea5]  
    state = response[:results][0][:locations][0][:adminArea3]
    destination_city = "#{city}, #{state}"
  end

  private
  # MOVE TO SERVICE IF TIME ALLOWS
  def self.travel_time(start, destination)
    response = map_quest_conn.get('route') do |req|
      req.params[:from] = start
      req.params[:to] = destination
    end

    data = JSON.parse(response.body, symbolize_names: true)
    seconds = data[:route][:realTime]
    minutes = seconds / 60
    hours = minutes / 60
    remainder = minutes % 60
    if hours > 0
      travel_time = "#{hours} hours #{remainder} min" 
    else
      travel_time = "#{minutes} min" 
    end
    travel_time
  end

  def self.map_quest_conn
    conn = Faraday.new(      url: 'http://www.mapquestapi.com/directions/v2/',
      params: { key: ENV['MAPQUEST_GEOCODING_API_KEY'] }
    )
  end

end
