class Forecast
  attr_reader :type, :current_weather, :daily_weather, :hourly_weather

  def initialize(attributes)
    @id = attributes[:id]
    @type = 'forecast'
    @current = attributes[:current]
    @daily = attributes[:daily]
    @hourly = attributes[:hourly]
  end
end
