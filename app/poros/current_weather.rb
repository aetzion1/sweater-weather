class CurrentWeather

  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(attributes)
    @datetime = Time.at(attributes[:dt]).to_s #getlocal.to_s
    @sunrise = Time.at(attributes[:sunrise]).to_s
		@sunset = Time.at(attributes[:sunset]).to_s
		@temperature = attributes[:temp]
		@feels_like = attributes[:feels_like]
		@humidity = attributes[:humidity]
		@uvi = attributes[:uvi]
		@visibility = attributes[:visibility]
		@conditions = attributes[:weather][0][:description]
		@icon = attributes[:weather][0][:icon]
  end
end
