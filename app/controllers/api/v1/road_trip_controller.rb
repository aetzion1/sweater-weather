class Api::V1::RoadTripController < ApplicationController
  def create
    return render_invalid_parameters('No parameters required, please') if request.query_parameters.present?
    # wouldnt it be better to just ignore the params, rather than make invalid? ^ ^ ^
    return render_invalid_api if User.find_by(api_key: road_trip_params[:api_key]).nil? 
    return render_invalid_parameters if road_trip_params[:origin].blank? 
    return render_invalid_parameters if road_trip_params[:destination].blank? 
    return render_invalid_parameters if road_trip_params[:api_key].blank? 

    if road_trip_params[:origin].present? & road_trip_params[:destination].present?
      roadtrip = RoadtripFacade.get_roadtrip(road_trip_params[:origin], road_trip_params[:destination])
    else
      render_invalid_input('Please specify locations')
    end
    # render json: (roadtrip ? (RoadTripSerializer.new(roadtrip), status: :created) : { data: {} })
    render json: RoadtripSerializer.new(roadtrip), status: :created
  end
  
  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
