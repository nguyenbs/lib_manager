Rails.application.routes.draw do
  root 'page#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :items, only: [:index, :show]

  post 'items/search', to: 'items#search'
  post 'search', to: 'page#search'
end
