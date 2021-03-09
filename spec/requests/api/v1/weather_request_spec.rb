require 'rails_helper'

RSpec.describe 'weather api' do
  describe 'forecast happy paths' do
    it 'sends weather forecast', :vcr do
      parameters = {location: 'denver, co'}
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      get '/api/v1/forecast', params: parameters, headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

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

  describe 'forecast sad paths' do
    it 'returns an error if header ACCEPT is missing' do 
      headers = {'CONTENT_TYPE' => 'application/json'}
      parameters = {location: 'denver, co'}
      get '/api/v1/forecast', params: parameters, headers: headers

      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end

    it 'returns an error if header CONTENT_TYPE is missing' do 
      headers = {'ACCEPT' => 'application/json'}
      parameters = {location: 'denver, co'}
      get '/api/v1/forecast', params: parameters, headers: headers

      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end

    it 'returns an error if location parameter is missing' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      get '/api/v1/forecast', headers: headers
  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)
  
      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  
    it 'returns an error if location parameter is blank' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      parameters = {location: ''}
      get '/api/v1/forecast', params: parameters, headers: headers
  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  
    it 'returns an error if location parameter cannot be found', :vcr do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      parameters = {location: 'kjsadfkjsad%^67839'}
      get '/api/v1/forecast', params: parameters, headers: headers

      expect(response.status).to eq(404)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  
    it 'returns an error  if mapquest API call is unsuccessful' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      parameters = {location: 'denver, co'}

      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAPQUEST_GEOCODING_API_KEY']}&location=#{parameters[:location]}").to_return(status: 503)
      get '/api/v1/forecast', params: parameters, headers: headers
  
      expect(response.status).to eq(503)
      errors = JSON.parse(response.body, symbolize_names: true)
  
      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  
    it 'returns an error  if openweather API call is unsuccessful' do
      allow(WeatherFacade).to receive(:get_coordinates).and_return({ lat: 39.738453, lng: -104.984853 })
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['OPENWEATHER_ONECALL_API_KEY']}&exclude=minutely,alerts&lat=39.738453&lon=-104.984853").to_return(status: 503)
  
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      parameters = {location: 'denver, co'}
      get '/api/v1/forecast', params: parameters, headers: headers
  
      expect(response.status).to eq(503)
      errors = JSON.parse(response.body, symbolize_names: true)
  
      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  






  end
end
