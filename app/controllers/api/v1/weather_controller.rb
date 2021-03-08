class Api::V1::WeatherController < ApplicationController
  def forecast
    return render_invalid_parameters if !(params[:location].present?)
    forecast = WeatherFacade.get_forecast(forecast_params[:location])
    render json: ForecastSerializer.new(forecast)
  end

  private

  def forecast_params
    params.permit(:location)
  end
end
