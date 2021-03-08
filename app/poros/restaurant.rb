class Restaurant
  attr_reader :name,
              :address

  def initialize(attributes)
		@name = attributes[:businesses][0][:name]
		@address = attributes[:businesses][0][:location][:display_address]
  end
end
