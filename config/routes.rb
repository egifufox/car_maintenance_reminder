Rails.application.routes.draw do
  # 開発環境でのみメール確認画面を表示
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Devise のルーティング(OmniAuth コールバックコントローラーを指定)
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'static_pages#top'

  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :oil_change_records, only: [:new, :create, :edit, :update, :destroy]
  end

  # エラーページのルーティング
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # 利用規約・プライバシーポリシー
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'

  # 使い方ページ
  get 'guide', to: 'pages#guide'

  # Cron用のAPIエンドポイント
  namespace :api do
    namespace :v1 do
      post 'cron/send_oil_change_reminders', to: 'cron#send_oil_change_reminders'
    end
  end
end
