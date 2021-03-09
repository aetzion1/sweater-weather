class Image
  attr_reader :id, :location, :image_url, :credits

  def initialize(location, image, credits)
    @id = nil
    @location = location
    @image_url = image[:urls][:raw]
    @credits = format_credits(image[:user], credits)
  end

  def format_credits(user_info, credit_info)
    {
      author: user_info[:name],
      author_url: "#{user_info[:links][:html]}#{credit_info[:author_url_params]}",
      source: credit_info[:source_url],
      source_url: credit_info[:source]
    }
  end
end
