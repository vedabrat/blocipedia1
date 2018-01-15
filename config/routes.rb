Rails.application.routes.draw do


  get 'collaborators/_form'

  resources :downgrade, only: [:new, :create]
  post 'downgrade/create'
  devise_for :users
  get 'welcome/index'
  get 'charges/create'
  get 'welcome/about'
  resources :wikis
  get 'wikis/new'
  resources :charges, only: [:new, :create]
  root to: 'welcome#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
