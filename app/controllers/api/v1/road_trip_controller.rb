class Api::V1::RoadTripController < ApplicationController
  def create
    return render_invalid_parameters('No parameters required, please') if request.query_parameters.present?
    return render_invalid_api if User.find_by(api_key: road_trip_params[:api_key]).nil?
    return render_invalid_parameters if road_trip_params[:origin].blank?
    return render_invalid_parameters if road_trip_params[:destination].blank?
    return render_invalid_parameters if road_trip_params[:api_key].blank?

    roadtrip = RoadtripFacade.get_roadtrip(road_trip_params[:origin], road_trip_params[:destination])
    # render json: (roadtrip ? (RoadTripSerializer.new(roadtrip), status: :created) : { data: {} })
    render json: RoadtripSerializer.new(roadtrip), status: :created
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
