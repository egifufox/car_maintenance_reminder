Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#top'

  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :oil_change_records, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
