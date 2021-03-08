require 'rails_helper'

RSpec.describe 'Weather Facade' do
  it 'returns latitude and longitude for a location', :vcr do
    location = 'denver, co'

    coordinates = WeatherFacade.get_coordinates(location)
    expect(coordinates).to be_a(Hash)
    expect(coordinates[:lat]).to be_a(Float)
    expect(coordinates[:lng]).to be_a(Float)
  end

  it 'returns forecast data', :vcr do
    location = 'denver, co'
    forecast = WeatherFacade.get_forecast(location)
    expect(forecast).to be_a(Forecast)

    expect(forecast.current_weather).to be_a(CurrentWeather)
    expect(forecast.current_weather.datetime).to be_a(String)
    expect(forecast.current_weather.sunrise).to be_a(String)
    expect(forecast.current_weather.sunset).to be_a(String)
    expect(forecast.current_weather.temperature).to be_a(Float)
    expect(forecast.current_weather.feels_like).to be_a(Float)
    expect(forecast.current_weather.humidity).to be_a(Integer)
    expect(forecast.current_weather.uvi).to be_a(Integer)
    expect(forecast.current_weather.visibility).to be_a(Integer)
    expect(forecast.current_weather.conditions).to be_a(String)
    expect(forecast.current_weather.icon).to be_a(String)

    expect(forecast.daily_weather).to be_an(Array)
    expect(forecast.daily_weather.count).to eq(5)
    expect(forecast.daily_weather[0]).to be_a(DailyWeather)
    expect(forecast.daily_weather[0].date).to be_a(String)
    expect(forecast.daily_weather[0].sunrise).to be_a(String)
    expect(forecast.daily_weather[0].sunset).to be_a(String)
    expect(forecast.daily_weather[0].max_temp).to be_a(Float)
    expect(forecast.daily_weather[0].min_temp).to be_a(Float)
    expect(forecast.daily_weather[0].conditions).to be_a(String)
    expect(forecast.daily_weather[0].icon).to be_a(String)

    expect(forecast.hourly_weather).to be_an(Array)
    expect(forecast.hourly_weather.count).to eq(8)
    expect(forecast.hourly_weather[0]).to be_a(HourlyWeather)
    expect(forecast.hourly_weather[0].time).to be_a(String)
    expect(forecast.hourly_weather[0].temperature).to be_a(Float)
    expect(forecast.hourly_weather[0].conditions).to be_a(String)
    expect(forecast.hourly_weather[0].icon).to be_a(String)
  end
end
