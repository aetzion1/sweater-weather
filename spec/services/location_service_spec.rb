require 'rails_helper'

RSpec.describe LocationService do
  it 'get latitude and longitude', :vcr do
    location = 'denver, co'
    data = LocationService.coordinates(location)
    require 'pry'; binding.pry
    expect(data).to be_a(Hash)
    expect(data).to have_key :results

    results = data[:results]
    expect(results).to be_an(Array)

    first_result = results.first

    expect(first_result).to have_key :locations

    first_location = first_result[:locations].first
    expect(first_location).to have_key :latLng

    expect(first_location[:latLng]).to be_a(Hash)
    expect(first_location[:latLng][:lat]).to be_a(Float)
    expect(first_location[:latLng][:lng]).to be_a(Float)
  end
end
