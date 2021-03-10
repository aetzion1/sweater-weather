class TravelService
  class << self
    def travel_time(origin, destination)
      response = map_quest_conn.get('route') do |req|
        req.params[:from] = origin
        req.params[:to] = destination
      end
      data = JSON.parse(response.body, symbolize_names: true)
      return "impossible" if data[:route][:routeError][:errorCode] == 2
      data[:route][:formattedTime]
    end

    def map_quest_conn
      Faraday.new(
        url: 'http://www.mapquestapi.com/directions/v2/',
        params: { key: ENV['MAPQUEST_GEOCODING_API_KEY'] }
      )
    end
  end
end
