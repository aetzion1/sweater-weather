class RestaurantService
  class << self
    def get_restaurant(food, coordinates, arrival_time)
      response = yelp_conn.get('businesses/search') do |req|
        req.params['term'] = food.downcase
        req.params['latitude'] = coordinates[:lat]
        req.params['longitude'] = coordinates[:lng]
        req.params['open_at'] = arrival_time.to_i.to_s
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def travel_time(start, destination)
      response = map_quest_conn.get('route') do |req|
        req.params[:from] = start
        req.params[:to] = destination
      end
      data = JSON.parse(response.body, symbolize_names: true)
      data[:route][:realTime]
    end

    def yelp_conn
      Faraday.new(url: 'https://api.yelp.com/v3/') do |req|
        req.headers['Authorization'] = ENV['YELP_FUSION_API_KEY']
      end
    end

    def map_quest_conn
      Faraday.new(
        url: 'http://www.mapquestapi.com/directions/v2/',
        params: { key: ENV['MAPQUEST_GEOCODING_API_KEY'] }
      )
    end
  end
end
