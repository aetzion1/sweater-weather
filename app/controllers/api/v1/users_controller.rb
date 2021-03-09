class Api::V1::UsersController < ApplicationController
  def create
    return render_invalid_parameters('No parameters required, please') if request.query_parameters.present?

    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render_invalid_user
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
