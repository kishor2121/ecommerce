Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admin/sessions' }
  resources :products
  resources :categories
  resources :categories, only: [:show]

  resource :admin, only: [:show], controller: :admin
  get "up" => "rails/health#show", as: :rails_health_check
  root "products#index"
end
