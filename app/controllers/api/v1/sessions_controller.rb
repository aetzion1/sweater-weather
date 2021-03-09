class Api::V1::SessionsController < ApplicationController
  def create
    return render_invalid_parameters('No parameters required, please') if request.query_parameters.present?

    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      render json: UsersSerializer.new(user), status: :ok
    else
      render_invalid_user
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
