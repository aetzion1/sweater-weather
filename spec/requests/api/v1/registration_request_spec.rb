require 'rails_helper'

describe "registration API" do
	describe "registration happy paths" do
		it "creates a user based on specific input", :vcr do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      post '/api/v1/users', params: body.to_json, headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(User.count).to eq(1)
      expect(User.last.email).to eq("whatever@example.com")

      user = JSON.parse(response.body, symbolize_names: true)
      expect(user[:data][:id]).to eq(User.last.id.to_s)
      expect(user[:data][:type]).to eq('user')
      expect(user[:data][:type]).to eq('user')
      expect(user[:data][:attributes][:email]).to eq(User.last.email)
      expect(user[:data][:attributes][:api_key]).to eq(User.last.api_key)
    end
  end

  describe "registration sad paths" do
    it 'returns an error if header ACCEPT is missing' do 
      headers = {'CONTENT_TYPE' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      post '/api/v1/users', params: body.to_json, headers: headers


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
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      post '/api/v1/users', params: body.to_json, headers: headers


      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end

    it 'returns an error if body is missing' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      post '/api/v1/users', headers: headers
  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)
  
      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  
    it 'returns an error if email is blank' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "",
        "password": "password",
        "password_confirmation": "password"
      }
      post '/api/v1/users', params: body.to_json, headers: headers

  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if password is blank' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "",
        "password_confirmation": "password"
      }
      post '/api/v1/users', params: body.to_json, headers: headers

  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if password confirmation is blank' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": ""
      }
      post '/api/v1/users', params: body.to_json, headers: headers

  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if passwords do not match' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "paSsword"
      }
      post '/api/v1/users', params: body.to_json, headers: headers

  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end

    it 'returns an error if parameters are passed' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      post '/api/v1/users?email=maliciousturtle@example.com', params: body.to_json, headers: headers
  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  end
end
