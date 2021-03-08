require 'rails_helper'

RSpec.describe ForecastService do
  it 'get forecast', :vcr do
    coordinates = {
      "lat": 39.738453,
      "lng": -104.984853
    }
    data = ForecastService.forecast(coordinates)
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
    expect(current[:temp]).to be_a(Numeric)

    expect(daily[0]).to have_key :dt
    expect(daily[0][:dt]).to be_a(Integer)
    expect(daily[0]).to have_key :sunrise
    expect(daily[0][:sunrise]).to be_a(Integer)

    expect(hourly[0]).to have_key :dt
    expect(hourly[0][:dt]).to be_a(Integer)
    expect(hourly[0][:weather][0][:description]).to be_a(String)
  end
end
