class Forecast
  attr_reader :id, :destination_city, :travel_time, :forecast, :restaurant

  def initialize(destination_city, travel_time, forecast)
    @id = nil
    @destination_city = destination_city
    @travel_time = travel_time
    @forecast = forecast
    @restaurant = restaurant
  end

end
