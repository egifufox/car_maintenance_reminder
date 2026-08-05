Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#top'

  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :oil_change_records, only: [:new, :create, :edit, :update, :destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # エラーページのルーティング
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # 利用規約・プライバシーポリシー
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'

  # 使い方ページ
  get 'guide', to: 'pages#guide'
end
