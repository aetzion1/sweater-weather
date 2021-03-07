class Api::V1::WeatherController < ApplicationController
  def forecast
    require 'pry'; binding.pry
    return render json: { error: 'Specify a location' }, status: '400' unless params[:location]

    forecast = if forecast_params[:location].blank?
      nil
    else
      WeatherFacade.get_forecast(forecast_params[:location])
    end
    
    render json: (forecast ? ForecastSerializer.new(forecast) : { data: [] })
  end

  private

  def forecast_params
    params.permit(:location)
  end
end
