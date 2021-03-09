class Api::V1::UserControllert < ApplicationController
  def create
    user = user_params
    user[:email] = user[:email].downcase
    User.create(user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
  
end