class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attribute :current_weather, :daily_weather, :hourly_weather
  end
end
