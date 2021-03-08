class MunchiesForecast
  attr_reader :summary,
              :temperature

  def initialize(attributes)
		@summary = attributes[:weather][0][:description]
		@temperature = attributes[:temp]
  end
end
