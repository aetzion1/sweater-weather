require 'rails_helper'

RSpec.describe 'weather api' do
  describe 'forecast happy paths' do
    it 'sends weather forecast', :vcr do
      parameters = {location: 'denver, co'}
      get '/api/v1/forecast', params: parameters

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data][:type]).to eq('forecast')

      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:datetime)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunrise)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunset)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:conditions)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)

      expect(forecast[:data][:attributes]).to have_key(:daily_weather)
      expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:date)
      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:sunrise)
      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:sunset)
      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:max_temp)
      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:min_temp)
      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:conditions)
      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:icon)

      expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
      expect(forecast[:data][:attributes][:hourly_weather]).to be_a(Array)
      expect(forecast[:data][:attributes][:hourly_weather].count).to eq(8)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:time)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:temperature)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:conditions)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:icon)
    end
  end
end
