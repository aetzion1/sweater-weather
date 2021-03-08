require 'rails_helper'

RSpec.describe 'munchies api' do
  describe 'munchies happy paths' do
    it 'sends recommendation info', :vcr do
      parameters = {start: 'denver, co', destination: 'pueblo, co', food: 'hamburger'}
      get '/api/v1/munchies', params: parameters

      expect(response).to be_successful

      recommendation = JSON.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
      expect(recommendation[:data]).to have_key(:id)
      expect(recommendation[:data][:id]).to eq(nil)
      expect(recommendation[:data][:type]).to eq('munchie')

      expect(recommendation[:data][:attributes]).to have_key(:destination_city)
      expect(recommendation[:data][:attributes][:destination_city]).to be_a(String)
      expect(recommendation[:data][:attributes]).to have_key(:travel_time)
      expect(recommendation[:data][:attributes][:travel_time]).to be_a(String)
      expect(recommendation[:data][:attributes]).to have_key(:forecast)
      expect(recommendation[:data][:attributes][:forecast]).to be_a(Hash)
      expect(recommendation[:data][:attributes][:forecast]).to have_key(:summary)
      expect(recommendation[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(recommendation[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(recommendation[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(recommendation[:data][:restaurant]).to have_key(:name)
      expect(recommendation[:data][:attributes][:name]).to be_a(String)
      expect(recommendation[:data][:restaurant]).to have_key(:address)
      expect(recommendation[:data][:attributes][:address]).to be_a(String)
    end
  end
end
