class LocationService
  def self.coordinates(location)
    response = conn.get("address") do |req|
      req.params['key'] = ENV['MAPQUEST_GEOCODING_API_KEY']
      req.params['location'] = location.downcase
    end

    response = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/")
  end
end
