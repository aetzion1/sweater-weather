require 'rails_helper'

RSpec.describe Image do
  it 'exists and has attributes' do
    location = "denver, co"
    data = File.read('./spec/fixtures/image.json')
    credits = ImageService.unsplash_credits

    image_data = JSON.parse(data, symbolize_names: true)
    image = Image.new(location, image_data, credits)
  
    expect(image).to be_an(Image)
    expect(image.id).to eq(nil)
    expect(image.location).to eq(location)
    expect(image.image_url).to eq(image_data[:urls][:raw])
    expect(image.credits).to eq(
      {
        author: image_data[:user][:name],
        author_url: "#{image_data[:user][:links][:html]}#{credits[:author_url_params]}",
        source: credits[:source_url],
        source_url: credits[:source]
      }
    )
  end
end
