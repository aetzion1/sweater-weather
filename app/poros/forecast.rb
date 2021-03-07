class Forecast
  attr_reader :latitude, :longitude

  def initialize(attributes)
    require 'pry'; binding.pry
    @latitude = attributes[:lat]
    @longitude = attributes[:lng]
  end
end