require 'rails_helper'

RSpec.describe TravelService do
  it 'can get travel time', :vcr do
    origin = 'denver, co'
    destination = 'los angeles, ca'

    data = TravelService.travel_time(origin, destination)
    expect(data).to be_a(String)
  end

  it 'can tell if travel time is impossible', :vcr do
    origin = 'denver, co'
    destination = 'London, UK'

    data = TravelService.travel_time(origin, destination)
    expect(data).to eq("impossible")
  end
end
