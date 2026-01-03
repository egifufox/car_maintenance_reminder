class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :info, :warning
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時にnameを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント更新時にnameを許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
