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
    require 'pry'; binding.pry
    expect(forecast.current_weather).to be_a(Hash)
    expect(forecast.current_weather[:date_time]).to be_a(DateTime)
    expect(forecast.current_weather[:temperature]).to be_a(Float)
    expect(forecast.daily_weather).to be_an(HaArraysh)
    expect(forecast.daily_weather[:date]).to be_a(DateTime)
    expect(forecast.daily_weather[:sunrise]).to be_a(DateTime)
    expect(forecast.hourly_weather).to be_a(Array)
    expect(forecast.hourly_weather[:time]).to be_a(DateTime)
    expect(forecast.hourly_weather[:conditions]).to be_a(DateTime)
  end
end
