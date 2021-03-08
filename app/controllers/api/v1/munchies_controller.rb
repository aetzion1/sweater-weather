class Api::V1::MunchiesController < ApplicationController
  def recommendation
    return render json: { error: 'We need more info, please' }, status: '400' unless params[:start]
    return render json: { error: 'We need more info, please' }, status: '400' unless params[:destination]
    return render json: { error: 'We need more info, please' }, status: '400' unless params[:food]

    if recommendation_params[:start].present? & recommendation_params[:destination].present? & recommendation_params[:food].present?
      recommendation = MunchiesFacade.get_recommendation(recommendation_params[:start], recommendation_params[:destination], recommendation_params[:food])
    end
    render json: (recommendation ? MunchieSerializer.new(recommendation) : { data: {} })
  end

  private

  def recommendation_params
    params.permit(:start, :destination, :food)
  end
end
