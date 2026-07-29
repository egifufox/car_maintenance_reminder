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

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    vehicles_path  # 車両一覧のパスに変更
  end

  # サインアップ後のリダイレクト先
  def after_sign_up_path_for(resource)
    vehicles_path  # 車両一覧のパスに変更
  end
end
