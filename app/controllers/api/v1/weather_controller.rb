class Api::V1::WeatherController < ApplicationController
  def forecast
    return render json: { error: 'Specify a location' }, status: '400' unless params[:location]
    
    forecast = WeatherFacade.get_forecast(forecast_params[:location]) if forecast_params[:location].present?
    render json: (forecast ? ForecastSerializer.new(forecast) : { data: {} })
  end

  private

  def forecast_params
    params.permit(:location)
  end
end
