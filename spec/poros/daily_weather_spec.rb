require 'rails_helper'

RSpec.describe DailyWeather do
  it 'exists and has attributes', :vcr do
    data = File.read('./spec/fixtures/daily_weather.json')
    daily_data = JSON.parse(data, symbolize_names: true)
    daily_weather = daily_data.first(5).map do |day|
      DailyWeather.new(day)
    end

    expect(daily_weather).to be_an(Array)
    expect(daily_weather.count).to eq(5)
    expect(daily_weather[0]).to be_a(DailyWeather)
    expect(daily_weather[0].date).to eq(Time.at(daily_data[0][:dt]).getlocal.strftime('%Y-%m-%d'))
    expect(daily_weather[0].sunrise).to eq(Time.at(daily_data[0][:sunrise]).getlocal.to_s)
    expect(daily_weather[0].sunset).to eq(Time.at(daily_data[0][:sunset]).getlocal.to_s)
    expect(daily_weather[0].max_temp).to eq(daily_data[0][:temp][:max])
    expect(daily_weather[0].min_temp).to eq(daily_data[0][:temp][:min])
    expect(daily_weather[0].conditions).to eq(daily_data[0][:weather][0][:description])
    expect(daily_weather[0].icon).to eq(daily_data[0][:weather][0][:icon])
  end
end
