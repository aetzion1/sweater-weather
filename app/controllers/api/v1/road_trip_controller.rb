class Api::V1::RoadTripController < ApplicationController
  def create
    return render_invalid_parameters('No parameters required, please') if request.query_parameters.present?
    roadtrip = RoadTrip.new(input)
    if roadtrip.save
      render json: RoadTripSerializer.new(user), status: :created
    else
      render_invalid_input
    end
  end
end