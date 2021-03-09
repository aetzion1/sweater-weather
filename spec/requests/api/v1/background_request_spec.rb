require 'rails_helper'

describe "backgrounds API" do
	describe "backgrounds happy paths" do
		it "retrieves an image based on a specified location", :vcr do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
			params = {location: 'denver, co'}
      get '/api/v1/backgrounds', params: params, headers: headers
      # backgrounds_path, params: params, headers: headers

			expect(response).to be_successful
			expect(response.status).to eq(200)
			data = JSON.parse(response.body, symbolize_names: true)

			expect(data).to be_a(Hash)
			expect(data).to have_key(:data)
			expect(data[:data].keys).to match_array(%i[id type attributes])
			expect(data[:data][:id]).to eq(nil)
			expect(data[:data][:type]).to eq('image')
			expect(data[:data][:attributes].keys).to match_array(%i[location image_url credits])
			expect(data[:data][:attributes][:location]).to eq(params[:location])
			expect(data[:data][:attributes][:credits].keys).to match_array(%i[author author_url source source_url])
		end
	end

	describe 'forecast sad paths' do
		it 'returns an error if header ACCEPT is missing' do 
			headers = {'CONTENT_TYPE' => 'application/json'}
			params = {location: 'denver, co'}
      get '/api/v1/backgrounds', params: params, headers: headers

			expect(response.status).to eq(400)
			errors = JSON.parse(response.body, symbolize_names: true)

			expect(errors).to be_a(Hash)
			expect(errors).to have_key(:errors)
			expect(errors[:errors]).to be_an(Array)
			expect(errors[:errors][0]).to be_a(String)
		end

		it 'returns an error if header CONTENT_TYPE is missing' do 
			headers = {'ACCEPT' => 'application/json'}
			params = {location: 'denver, co'}
      get '/api/v1/backgrounds', params: params, headers: headers

			expect(response.status).to eq(400)
			errors = JSON.parse(response.body, symbolize_names: true)

			expect(errors).to be_a(Hash)
			expect(errors).to have_key(:errors)
			expect(errors[:errors]).to be_an(Array)
			expect(errors[:errors][0]).to be_a(String)
		end

		it 'returns an error if location parameter is missing' do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      get '/api/v1/backgrounds', headers: headers
	
			expect(response.status).to eq(400)
			errors = JSON.parse(response.body, symbolize_names: true)
	
			expect(errors).to be_a(Hash)
			expect(errors).to have_key(:errors)
			expect(errors[:errors]).to be_an(Array)
			expect(errors[:errors][0]).to be_a(String)
		end
	
		it 'returns an error if location parameter is blank' do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
			params = {location: ''}
      get '/api/v1/backgrounds', params: params, headers: headers
	
			expect(response.status).to eq(400)
			errors = JSON.parse(response.body, symbolize_names: true)

			expect(errors).to be_a(Hash)
			expect(errors).to have_key(:errors)
			expect(errors[:errors]).to be_an(Array)
			expect(errors[:errors][0]).to be_a(String)
		end
	
		it 'returns an error if location parameter cannot be found', :vcr do
			headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
			params = {location: 'kjsadfkjsad%^67839'}
      get '/api/v1/backgrounds', params: params, headers: headers

			expect(response.status).to eq(404)
			errors = JSON.parse(response.body, symbolize_names: true)

			expect(errors).to be_a(Hash)
			expect(errors).to have_key(:errors)
			expect(errors[:errors]).to be_an(Array)
			expect(errors[:errors][0]).to be_a(String)
		end

		it 'returns an error  if mapquest API call is unsuccessful' do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      params = {location: 'denver, co'}

			stub_request(:get, "https://api.unsplash.com/photos/random?client_id=#{ENV['UNSPLASH_API_KEY']}&query=#{params[:location]}").to_return(status: 503)

      get '/api/v1/backgrounds', params: params, headers: headers
  
      expect(response.status).to eq(503)
      errors = JSON.parse(response.body, symbolize_names: true)
  
      expect(errors).to be_a(Hash)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors][0]).to be_a(String)
    end
	end
end
