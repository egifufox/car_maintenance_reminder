# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    # OmniAuth から取得した認証情報
    auth = request.env['omniauth.auth']

    # ユーザーを検索または作成
    user = User.find_or_create_from_auth(auth)

    # ログイン処理
    auto_login(user)

    redirect_to root_path, notice: 'ログインしました'
  end

  def destroy
    logout
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
