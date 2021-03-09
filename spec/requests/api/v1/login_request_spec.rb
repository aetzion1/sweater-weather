require 'rails_helper'

describe "login API" do
  before :each do
    @user = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
  end

	describe "login happy paths" do
		it "logs a user in based on specific input", :vcr do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "password",
      }
      post '/api/v1/sessions', params: body.to_json, headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      # expect(User.count).to eq(1)
      # expect(User.last.email).to eq("whatever@example.com")

      session = JSON.parse(response.body, symbolize_names: true)
      expect(session[:data][:id]).to eq(@user.id.to_s)
      expect(session[:data][:type]).to eq('users')
      expect(session[:data][:attributes][:email]).to eq(@user.email)
      expect(session[:data][:attributes][:api_key]).to eq(@user.api_key)
    end
  end

  describe "login sad paths" do
    it 'returns an error if header ACCEPT is missing' do 
      headers = {'CONTENT_TYPE' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "password",
      }
      post '/api/v1/sessions', params: body.to_json, headers: headers

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
      }
      post '/api/v1/sessions', params: body.to_json, headers: headers


      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end

    it 'returns an error if body is missing' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      post '/api/v1/sessions', headers: headers
  
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
      }
      post '/api/v1/sessions', params: body.to_json, headers: headers

  
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
      }
      post '/api/v1/sessions', params: body.to_json, headers: headers

  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if password is incorrect' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "whatever@example.com",
        "password": "paSsword",
      }
      post '/api/v1/sessions', params: body.to_json, headers: headers

  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
    
    it 'returns an error if user doesnt exist do not match' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      body = {
        "email": "whateverdude@example.com",
        "password": "password",
      }
      post '/api/v1/sessions', params: body.to_json, headers: headers

  
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
      }
      post '/api/v1/sessions?email=maliciousturtle@example.com', params: body.to_json, headers: headers
  
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
  end
end
