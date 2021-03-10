require 'rails_helper'

RSpec.describe RoadtripForecast do
  it 'exists and has attributes' do
    data = File.read('./spec/fixtures/forecast_at_eta.json')
    forecast_at_eta = JSON.parse(data, symbolize_names: true)
    roadtrip_forecast = RoadtripForecast.new(forecast_at_eta)
  
    expect(roadtrip_forecast).to be_a(RoadtripForecast)
    expect(roadtrip_forecast.conditions).to eq(forecast_at_eta[:weather][0][:description])
    expect(roadtrip_forecast.temperature).to eq(forecast_at_eta[:temp])
  end
end
