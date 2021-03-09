class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :image_url, :credits
end
