require 'rails_helper'

RSpec.describe Roadtrip do
  it 'exists and has attributes' do
    start_city = "Denver, CO"
    end_city = "Miami, FL"
    travel_time =  "30 hours, 20 minutes"

    data = File.read('./spec/fixtures/forecast_at_eta.json')
    forecast_at_eta = JSON.parse(data, symbolize_names: true)
    weather_at_eta = RoadtripForecast.new(forecast_at_eta)

    roadtrip = Roadtrip.new(start_city, end_city, travel_time, weather_at_eta)
  
    expect(roadtrip).to be_a(Roadtrip)
    expect(roadtrip.start_city).to eq(start_city)
    expect(roadtrip.end_city).to eq(end_city)
    expect(roadtrip.travel_time).to eq(travel_time)
    expect(roadtrip.weather_at_eta.conditions).to eq(weather_at_eta.conditions)
    expect(roadtrip.weather_at_eta.temperature).to eq(weather_at_eta.temperature)
  end
end
