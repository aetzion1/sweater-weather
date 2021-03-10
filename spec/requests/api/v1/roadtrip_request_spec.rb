require 'rails_helper'

describe "road trip API" do
  before :each do
    @user = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
  end

	describe "road trip happy paths" do
		it "logs a user in based on specific input", :vcr do
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
      expect(session[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
      expect(session[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
  end

  describe "road trip sad paths" do
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
