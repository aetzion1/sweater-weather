class Forecast
  attr_reader :latitude, :longitude

  def initialize(attributes)
    @latitude = attributes[:lat]
    @longitude = attributes[:lng]
  end
end