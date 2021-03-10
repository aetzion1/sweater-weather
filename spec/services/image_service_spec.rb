require 'rails_helper'

RSpec.describe ImageService do
  it 'can call image api based on location', :vcr do
    location = 'denver, co'

    data = ImageService.call(location)
    expect(data).to be_a(Hash)
    expect(data).to have_key :urls
    expect(data).to have_key :user
    expect(data[:urls]).to have_key :raw    
  end

  it 'can get appropriate credits from the unsplash api' do
    data = ImageService.unsplash_credits
    
    expect(data).to be_a(Hash)
    expect(data).to have_key :source
    expect(data).to have_key :source_url
    expect(data).to have_key :author_url_params
    expect(data[:source]).to eq('Unsplash')
    expect(data[:source_url]).to eq('https://unsplash.com/?utm_source=weather-sweater&utm_medium=referral')
    expect(data[:author_url_params]).to eq('?utm_source=sweater-weather&utm_medium=referral')
  end
end
