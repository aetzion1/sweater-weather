class HourlyWeather
	attr_reader :time,
	            :temperature,
	            :wind_speed,
	            :wind_direction,
	            :conditions,
	            :icon

	def initialize(attributes)
		@time = Time.at(attributes[:dt]).strftime('%H:%M:%S')
		@temperature = attributes[:temp]
		@conditions = attributes[:weather][0][:description]
		@icon = attributes[:weather][0][:icon]
	end
end
