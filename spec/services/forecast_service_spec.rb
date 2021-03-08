require 'rails_helper'

RSpec.describe ForecastService do
  it 'get forecast', :vcr do
    coordinates = {
      "lat": 39.738453,
      "lng": -104.984853
    }
    data = ForecastService.forecast(coordinates)
    require 'pry'; binding.pry
    expect(data).to be_a(Hash)
    expect(data).to have_key :current
    expect(data).to have_key :daily
    expect(data).to have_key :hourly

    current = data[:current]
    daily = data[:daily]
    hourly = data[:hourly]

    expect(current).to have_key :dt
    expect(current[:dt]).to be_a(Integer)
    expect(current).to have_key :temp
    expect(current[:temp]).to be_a(Float)

    expect(daily).to have_key :dt
    expect(daily[:dt]).to be_a(Integer)
    expect(daily).to have_key :sunrise
    expect(daily[:sunrise]).to be_a(Float)

    expect(hourly).to have_key :dt
    expect(hourly[:dt]).to be_a(Integer)
  end
end
