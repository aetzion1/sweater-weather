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
    @datetime = Time.at(attributes[:dt]).getlocal.to_s
    @sunrise = Time.at(attributes[:sunrise]).getlocal.to_s
    @sunset = Time.at(attributes[:sunset]).getlocal.to_s
    @temperature = attributes[:temp]
    @feels_like = attributes[:feels_like]
    @humidity = attributes[:humidity]
    @uvi = attributes[:uvi]
    @visibility = attributes[:visibility]
    @conditions = attributes[:weather][0][:description]
    @icon = attributes[:weather][0][:icon]
  end
end
