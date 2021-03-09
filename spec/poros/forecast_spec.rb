require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes' do
    data = File.read('./spec/fixtures/current_weather.json')
    current_data = JSON.parse(data, symbolize_names: true)
    current_weather = CurrentWeather.new(current_data)

    data = File.read('./spec/fixtures/daily_weather.json')
    daily_data = JSON.parse(data, symbolize_names: true)
    daily_weather = daily_data.first(5).map do |day|
      DailyWeather.new(day)
    end

    data = File.read('./spec/fixtures/hourly_weather.json')
    hourly_data = JSON.parse(data, symbolize_names: true)
    hourly_weather = hourly_data.first(8).map do |day|
      HourlyWeather.new(day)
    end

    forecast = Forecast.new(current_weather, daily_weather, hourly_weather)

    expect(forecast).to be_a(Forecast)
		expect(forecast.current_weather).to eq(current_weather)
		expect(forecast.daily_weather).to eq(daily_weather)
		expect(forecast.hourly_weather).to eq(hourly_weather)
  end
end
