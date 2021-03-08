class ForecastService
  class << self
    def forecast(coordinates)
      response = conn.get("onecall") do |req|
        req.params[:appid] = ENV['OPENWEATHER_ONECALL_API_KEY']
        req.params[:lat] = coordinates[:lat]
        req.params[:lon] = coordinates[:lng]
        req.params[:exclude] = 'minutely,alerts'
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      Faraday.new(url: 'https://api.openweathermap.org/data/2.5/')
    end
  end
end
