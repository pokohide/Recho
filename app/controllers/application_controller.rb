class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username display_name email password password_confirmation rememberable thumbnail])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email display_name password password_confirmation rememberable thumbnail])
  end
end
