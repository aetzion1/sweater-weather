require 'rails_helper'

RSpec.describe 'Weather Facade' do
  it 'returns latitude and longitude for a location', :vcr do
    location = 'denver, co'

    coordinates = WeatherFacade.get_coordinates(location)
    expect(coordinates).to be_a(Forecast)
    expect(coordinates.latitude).to be_a(Float)
    expect(coordinates.longitude).to be_a(Float)
  end
end
