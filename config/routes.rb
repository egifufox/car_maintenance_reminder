Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#top'

  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update, :destroy]
end
