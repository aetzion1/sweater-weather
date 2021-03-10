class ApplicationController < ActionController::API
  before_action :validate_headers

  rescue_from NoMethodError, with: :render_location_not_found
  rescue_from JSON::ParserError, with: :render_api_unavailable

  def render_invalid_headers
    render json: ErrorSerializer.serialize('Invalid content type or request'), status: :bad_request
  end

  def render_invalid_parameters(error = 'Please specify a location')
    render json: ErrorSerializer.serialize(error), status: :bad_request
  end

  def render_location_not_found
    render json: ErrorSerializer.serialize('Location not found'), status: :not_found
  end

  def render_api_unavailable
    render json: ErrorSerializer.serialize('Apologies, our external API is unavailable'), status: :service_unavailable
  end

  def render_invalid_user
    render json: ErrorSerializer.serialize('Invalid user input'), status: :bad_request
  end

  def render_invalid_api
    render json: ErrorSerializer.serialize('Invalid api key'), status: :unauthorized
  end

  def validate_headers
    valid_content_type = request.content_type == 'application/json'
    valid_accept = request.accept == 'application/json'
    render_invalid_headers unless valid_content_type && valid_accept
  end
end
