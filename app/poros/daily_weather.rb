class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(attributes)
    @date = Time.at(attributes[:dt]).getlocal.strftime('%Y-%m-%d')
    @sunrise = Time.at(attributes[:sunrise]).getlocal.to_s
    @sunset = Time.at(attributes[:sunset]).getlocal.to_s
    @max_temp = attributes[:temp][:max]
    @min_temp = attributes[:temp][:min]
    @conditions = attributes[:weather][0][:description]
    @icon = attributes[:weather][0][:icon]
  end
end
