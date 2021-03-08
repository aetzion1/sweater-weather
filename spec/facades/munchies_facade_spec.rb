require 'rails_helper'

RSpec.describe 'Munchies Facade' do
  before :each do
    @start = 'denver, co'
    @destination = 'pueblo, co'
    @food = 'hamburgers'
  end
  
  it 'returns travel time, forecast', :vcr do
    recommendation = MunchiesFacade.get_recommendation(@start, @destination, @food)

    expect(recommendation).to be_a(Munchies)
    expect(recommendation.destination_city).to be_a(String)
    expect(recommendation.destination_city).to eq("Pueblo, CO")
    expect(recommendation.travel_time).to be_a(String)
    expect(recommendation.forecast).to be_a(MunchiesForecast)
    expect(recommendation.forecast.summary).to be_a(String)
    expect(recommendation.forecast.temperature).to be_a(Numeric)
    expect(recommendation.restaurant).to be_a(Restaurant)
    expect(recommendation.restaurant.name).to be_a(String)
    expect(recommendation.restaurant.address[0]).to be_a(String)
  end

  it 'returns travel time if less than an hour', :vcr do
    recommendation = MunchiesFacade.get_recommendation(@start, 'littleton, co', @food)

    expect(recommendation).to be_a(Munchies)
    expect(recommendation.destination_city).to be_a(String)
    expect(recommendation.destination_city).to eq("Littleton, CO")
    expect(recommendation.travel_time).to be_a(String)
  end
end
