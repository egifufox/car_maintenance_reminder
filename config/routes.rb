Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#top'

  resources :vehicles, only: [:new, :create, :show]
  # 👇 この行を追加（後で車両一覧ページに変更予定）
  # root "home#index"  # ← 今は仮で設定
end
