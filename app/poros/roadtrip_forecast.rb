class RoadtripForecast
  attr_reader :temperature,
              :conditions

  def initialize(attributes)
		@temperature = attributes[:temp]
		@conditions = attributes[:weather][0][:description]
  end
end
