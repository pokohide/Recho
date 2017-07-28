class UsersController < ApplicationController
  def account
    @user = current_user
  end

  def show
    @user = User.find_by(username: params[:username])
  end
end
