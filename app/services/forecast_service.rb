class ForecastService
  def self.forecast(coordinates)
    response = conn.get("onecall") do |req|
      req.params[:appid] = ENV['OPENWEATHER_ONECALL_API_KEY']
      req.params[:lat] = coordinates[:lat]
      req.params[:lon] = coordinates[:lng]
      req.params[:exclude] = 'minutely,alerts'
    end

    response = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: "https://api.openweathermap.org/data/2.5/")
  end
end
