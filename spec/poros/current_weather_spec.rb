require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exists and has attributes' do
    data = File.read('./spec/fixtures/current_weather.json')
    current_data = JSON.parse(data, symbolize_names: true)
    current_weather = CurrentWeather.new(current_data)
  
    expect(current_weather).to be_a(CurrentWeather)
    expect(current_weather.conditions).to eq(current_data[:weather][0][:description])
    expect(current_weather.sunrise).to eq(Time.at(current_data[:sunrise]).getlocal.to_s)
    expect(current_weather.sunset).to eq(Time.at(current_data[:sunset]).getlocal.to_s)
    expect(current_weather.temperature).to eq(current_data[:temp])
    expect(current_weather.feels_like).to eq(current_data[:feels_like])
    expect(current_weather.humidity).to eq(current_data[:humidity])
    expect(current_weather.uvi).to eq(current_data[:uvi])
    expect(current_weather.visibility).to eq(current_data[:visibility])
    expect(current_weather.icon).to eq(current_data[:weather][0][:icon])
  end
end
