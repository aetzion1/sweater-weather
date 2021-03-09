class ImageService
  class << self
    def call(location)
      response = conn.get('/photos/random') do |req|
        req.params['query'] = location.downcase
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def unsplash_credits
      {
        source: 'Unsplash',
        source_url: 'https://unsplash.com/?utm_source=weather-sweater&utm_medium=referral',
        author_url_params: '?utm_source=sweater-weather&utm_medium=referral'
      }
    end

    private

    def conn
      @conn ||= Faraday.new('https://api.unsplash.com/') do |req|
        req.params[:client_id] = ENV['UNSPLASH_API_KEY']
      end
    end
  end
end
