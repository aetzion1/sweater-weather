class Api::V1::MunchiesController < ApplicationController
  def recommendation
    return render json: { error: 'We need more info, please' }, status: '400' unless params[:start, :destination, :food]

    if forecast_params[:start].present? & forecast_params[:destination].present? & forecast_params[:food].present?
      recommendation = MunchiesFacade.get_recommendation(forecast_params)
    end
    render json: (recommendation ? MunchiesSerializer.new(recommendation) : { data: {} })
  end

  private

  def recommendation_params
    params.permit(:start, :destination, :food)
  end
end
