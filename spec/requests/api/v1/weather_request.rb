require 'reails-helper'

describe 'weather api' do
  describe 'forecast happy paths' do
    it 'sends weather forecast' do
      get 'api/v1/forecast'

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to be_eq(null)
      expect(forecast[:data][:type]).to eq('forecast')

      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:datetime)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(forecast[:data][:attributes]).to have_key(:daily_weather)
      expect(forecast[:data][:attributes][:daily_weather]).to be_a(Hash)
      expect(forecast[:data][:attributes][:daily_weather]).to have_key(:date)
      expect(forecast[:data][:attributes][:daily_weather]).to have_key(:sunrise)
      expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
      expect(forecast[:data][:attributes][:hourly_weather]).to be_a(Array)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:time)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:conditions)
    end
  end
end
