class Api::V1::RoadTripController < ApplicationController
  def create
    return render_invalid_parameters('No parameters required, please') if request.query_parameters.present?
    # wouldnt it be better to just ignore the params, rather than make invalid? ^ ^ ^
    return render_invalid_input('Incorrect api_key'), status: :unauthorized unless User.find_by(api_key: roadtrip_params[:api_key]) 

    if roadtrip_params[:origin].present? & roadtrip_params[:destination].present?
      roadtrip = RoadTripFacade.get_roadtrip(roadtrip_params[:origin], roadtrip_params[:destination])
    else
      render_invalid_input('Please specify locations')
    end
    render json: (roadtrip ? RoadTripSerializer.new(roadtrip), status: :created : { data: {} })
  end
  
  private

  def roadtrip_params
    params.permit(:origin, :destination, :api_key)
  end
end
