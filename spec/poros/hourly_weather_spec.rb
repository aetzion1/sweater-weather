require 'rails_helper'

RSpec.describe DailyWeather do
  it 'exists and has attributes' do
    data = File.read('./spec/fixtures/hourly_weather.json')
    hourly_data = JSON.parse(data, symbolize_names: true)
    hourly_weather = hourly_data.first(8).map do |day|
      HourlyWeather.new(day)
    end

    expect(hourly_weather).to be_an(Array)
    expect(hourly_weather.count).to eq(8)
    expect(hourly_weather[0]).to be_a(HourlyWeather)
    expect(hourly_weather[0].time).to eq(Time.at(hourly_data[0][:dt]).getlocal.strftime('%H:%M:%S'))
    expect(hourly_weather[0].temperature).to eq(hourly_data[0][:temp])
    expect(hourly_weather[0].conditions).to eq(hourly_data[0][:weather][0][:description])
    expect(hourly_weather[0].icon).to eq(hourly_data[0][:weather][0][:icon])
  end
end
