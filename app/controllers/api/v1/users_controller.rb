class Api::V1::UserControllert < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user)
    else
      render_invalid_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end