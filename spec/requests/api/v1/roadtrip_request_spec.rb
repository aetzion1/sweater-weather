require 'rails_helper'

describe "road trip API" do
  before :each do
    @user = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
  end

	describe "road trip happy paths" do
		it "provides roadtrip data for trips that take 1+ hours", :vcr do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(201)

      session = JSON.parse(response.body, symbolize_names: true)
      expect(session[:data][:id]).to eq(nil)
      expect(session[:data][:type]).to eq('roadtrip')
      expect(session[:data][:attributes][:start_city]).to eq("Denver, CO")
      expect(session[:data][:attributes][:end_city]).to eq("Pueblo, CO")
      expect(session[:data][:attributes][:travel_time]).to be_a(String)
      expect(session[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
      expect(session[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
    
		it "provides roadtrip data for trips that take < an hour", :vcr do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "origin": "Denver,CO",
        "destination": "Westminster,CO",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(201)

      session = JSON.parse(response.body, symbolize_names: true)
      expect(session[:data][:id]).to eq(nil)
      expect(session[:data][:type]).to eq('roadtrip')
      expect(session[:data][:attributes][:start_city]).to eq("Denver, CO")
      expect(session[:data][:attributes][:end_city]).to eq("Westminster, CO")
      expect(session[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
      expect(session[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
  end

  describe "road trip sad paths" do
    it "provides appropriate response for 'impossible' trips'", :vcr do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "origin": "New York, NY",
        "destination": "London, UK",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(201)

      session = JSON.parse(response.body, symbolize_names: true)
      expect(session[:data][:id]).to eq(nil)
      expect(session[:data][:type]).to eq('roadtrip')
      expect(session[:data][:attributes][:start_city]).to eq("New York, NY")
      expect(session[:data][:attributes][:end_city]).to eq("London, ENG")
      expect(session[:data][:attributes][:travel_time]).to eq("impossible")
      expect(session[:data][:attributes][:weather_at_eta]).to eq({})
    end

    it 'returns an error if header ACCEPT is missing' do 
      headers = {'CONTENT_TYPE' => 'application/json'}
      body =   {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end

    it 'returns an error if header CONTENT_TYPE is missing' do 
      headers = {'ACCEPT' => 'application/json'}
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end

    it 'returns an error if body is missing' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      post '/api/v1/road_trip', headers: headers
  
      expect(response.status).to eq(401)
      errors = JSON.parse(response.body, symbolize_names: true)
  
      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  
    it 'returns an error if origin is blank' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "origin": "",
        "destination": "Pueblo,CO",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if destination is blank' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "origin": "Denver,CO",
        "destination": "",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if origin is missing' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "destination": "Denver,CO",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if destination is missing' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "origin": "Denver,CO",
        "api_key": "#{@user.api_key}"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if api_key is blank' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body =   {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": ""
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

  
      expect(response.status).to eq(401)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if api_key is incorrect' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "wrongkey"
      }
      post '/api/v1/road_trip', params: body.to_json, headers: headers

      expect(response.status).to eq(401)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if parameters are passed' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "wrongkey"
      }
      post '/api/v1/road_trip?email=maliciousturtle@example.com', params: body.to_json, headers: headers
  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  end
end
