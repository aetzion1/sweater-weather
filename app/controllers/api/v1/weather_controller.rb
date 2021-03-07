class Api::V1::WeatherController < ApplicationController
  def forecast
    forecast = if forecast_params[:location].blank?
      nil
    else
      Forecast.create!(forecast_params[:location].downcase)
    end
    render json: (forecast ? ForecastSerializer.new(forecast) : { data: [] })
  end

  private

  def forecast_params
    params.permit(:location)
  end
end
