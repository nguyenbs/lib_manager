Rails.application.routes.draw do
  root 'page#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, only: :index

  post 'books/search', to: 'books#search'
end
