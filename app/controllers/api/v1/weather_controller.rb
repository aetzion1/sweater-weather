class Api::V1::WeatherController < ApplicationController
  def forecast
    return render_invalid_parameters if !(params[:location].present?)
    forecast = WeatherFacade.get_forecast(weather_params[:location])
    render json: ForecastSerializer.new(forecast)
  end

  def background
    return render_invalid_parameters if !(params[:location].present?)
    background = WeatherFacade.get_image(weather_params[:location])
    render json: BackgroundSerializer.new(background)
  end

  private

  def weather_params
    params.permit(:location)
  end
end
