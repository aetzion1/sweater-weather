require 'rails_helper'

RSpec.describe 'Munchies Facade' do
  before :each do
    @start = 'denver, co'
    @destination = 'puebloc, co'
    @food = 'hamburgers'
  end

  it 'returns all recommendation info', :vcr do
  end
  
  it 'returns travel time', :vcr do
    recommendation = MunchiesFacade.get_recommendation(@start, @destination, @food)

    expect(recommendation).to be_a(Hash)
    expect(recommendation[:destination_city]).to be_a(string)
    expect(recommendation[:destination_city]).to eq("Pueblo, CO")
    expect(recommendation[:travel_time]).to be_a(string)
    expect(recommendation[:travel_time]).to eq("1 hours 48 min")
  end

  it 'returns current forecast at end location', :vcr do
    
  end

  # it 'returns restaurant name and address', :vcr do
  #   restaurant = WeatherFacade.get_restaurant(location)
    # expect(forecast).to be_a(Forecast)

    # expect(forecast.current_weather).to be_a(CurrentWeather)
    # expect(forecast.current_weather.datetime).to be_a(String)
    # expect(forecast.current_weather.sunrise).to be_a(String)
    # expect(forecast.current_weather.sunset).to be_a(String)
    # expect(forecast.current_weather.temperature).to be_a(Float)
    # expect(forecast.current_weather.feels_like).to be_a(Float)
    # expect(forecast.current_weather.humidity).to be_a(Integer)
    # expect(forecast.current_weather.uvi).to be_a(Float)
    # expect(forecast.current_weather.visibility).to be_a(Integer)
    # expect(forecast.current_weather.conditions).to be_a(String)
    # expect(forecast.current_weather.icon).to be_a(String)

    # expect(forecast.daily_weather).to be_an(Array)
    # expect(forecast.daily_weather.count).to eq(5)
    # expect(forecast.daily_weather[0]).to be_a(DailyWeather)
    # expect(forecast.daily_weather[0].date).to be_a(String)
    # expect(forecast.daily_weather[0].sunrise).to be_a(String)
    # expect(forecast.daily_weather[0].sunset).to be_a(String)
    # expect(forecast.daily_weather[0].max_temp).to be_a(Float)
    # expect(forecast.daily_weather[0].min_temp).to be_a(Float)
    # expect(forecast.daily_weather[0].conditions).to be_a(String)
    # expect(forecast.daily_weather[0].icon).to be_a(String)

    # expect(forecast.hourly_weather).to be_an(Array)
    # expect(forecast.hourly_weather.count).to eq(8)
    # expect(forecast.hourly_weather[0]).to be_a(HourlyWeather)
    # expect(forecast.hourly_weather[0].time).to be_a(String)
    # expect(forecast.hourly_weather[0].temperature).to be_a(Float)
    # expect(forecast.hourly_weather[0].conditions).to be_a(String)
    # expect(forecast.hourly_weather[0].icon).to be_a(String)
  end
end
