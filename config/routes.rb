Rails.application.routes.draw do
  devise_for :admins
  root 'page#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :items, only: [:index, :show]
  resources :carts, only: :index
  post 'items/search', to: 'items#search'
  post 'search', to: 'page#search'
  post 'borrow_item', to: 'carts#borrow_item'
  post 'update_process', to: 'carts#update_process'
end
