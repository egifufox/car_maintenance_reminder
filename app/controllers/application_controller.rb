class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :info, :warning
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 例外処理の追加
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from StandardError, with: :render_500 if Rails.env.production?

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

  private

  # 404エラーを表示するメソッド
  def render_404
    render 'errors/not_found', status: :not_found
  end

  # 500エラーを表示するメソッド
  def render_500(exception = nil)
    # エラーの詳細をログに記録（開発者が確認できるように）
    logger.error "Internal Server Error: #{exception.message}" if exception
    logger.error exception.backtrace.join("\n") if exception
    # 500エラーページを表示
    render 'errors/internal_server_error', status: :internal_server_error
  end
end
