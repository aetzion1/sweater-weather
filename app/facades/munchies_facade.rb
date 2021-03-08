class MunchiesFacade
  def self.get_forecast(start, destination, food)
    # DESTINATION CITY
    destination_city = get_destination_city(destination)
    # TRAVEL TIME
    # FORECAST (add exclusions to forecast service if time allows - filter to just current)
    coordinates = get_coordinates(destination)
    response = ForecastService.forecast(coordinates)
    summary_forecast = MunchiesForecast.new(response[:current])
    #RESTAURANT
    restaurant = Restaurant.new(input)
    Munchies.new(destination_city, travel_time, summary_forecast, restaurant)
  end
  
  def self.get_coordinates(location)
    response = LocationService.coordinates(location)
    response[:results][0][:locations][0][:latLng]
  end

  def self.get_destination_city(destination)
    response = LocationService.coordinates(location)
    city = response[:results][0][:locations][0][:adminArea5]  
    state = response[:results][0][:locations][0][:adminArea3]
    destination_city = "#{city}, #{state}"
  end
  # MOVE TO SERVICE IF TIME ALLOWS
  def self.travel_time(start, destination)
    response = map_quest_conn.get('route') do |req|
      req.params[:from] = start
      req.params[:to] = destination
    end

    data = JSON.parse(response.body, symbolize_names: true)
    travel_time = data[:route][:realTime]

    hours = minutes / 60
    minutes = minutes % 60
    if hours > 0
      travel_time = "#{hours} hours #{minutes} minutes" 
    else
      travel_time = "#{minutes} minutes" 
    end
    travel_time
  end

  def map_quest_conn
    conn = Faraday.new(
      url: 'http://www.mapquestapi.com/directions/v2/',
      params: { key: ENV['MAPQUEST_API_KEY'] }
    )
  end

end
