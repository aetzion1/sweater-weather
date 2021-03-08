class RestaurantService
  def self.get_restaurant(food, coordinates)
    response = conn.get('businesses/search') do |req|
      req.params['term'] = food.downcase
      req.params['latitude'] = coordinates[:lat]
      req.params['longitude'] = coordinates[:lng]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com/v3/') do |req|
      req.headers['Authorization'] = ENV['YELP_FUSION_API_KEY']
    end
  end
end
