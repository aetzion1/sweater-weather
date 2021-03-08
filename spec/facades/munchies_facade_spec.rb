require 'rails_helper'

RSpec.describe 'Munchies Facade' do
  before :each do
    @start = 'denver, co'
    @destination = 'pueblo, co'
    @food = 'hamburgers'
  end

  xit 'returns all recommendation info', :vcr do
  end
  
  it 'returns travel time', :vcr do
    recommendation = MunchiesFacade.get_recommendation(@start, @destination, @food)

    expect(recommendation).to be_a(Munchies)
    expect(recommendation.destination_city).to be_a(String)
    expect(recommendation.destination_city).to eq("Pueblo, CO")
    expect(recommendation.travel_time).to be_a(String)
  end

  it 'returns travel time if less than an hour', :vcr do
    recommendation = MunchiesFacade.get_recommendation(@start, 'littleton, co', @food)

    expect(recommendation).to be_a(Munchies)
    expect(recommendation.destination_city).to be_a(String)
    expect(recommendation.destination_city).to eq("Littleton, CO")
    expect(recommendation.travel_time).to be_a(String)
  end


  xit 'returns current forecast at end location', :vcr do

  end

  xit 'returns restaurant name and address', :vcr do
  #   restaurant = WeatherFacade.get_restaurant(location)
    # expect(forecast).to be_a(Forecast)
  end
end
