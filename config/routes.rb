Rails.application.routes.draw do
  root to: 'wikis#index'

  resources :downgrade, only: [:new, :create]
  post 'downgrade/create'
  devise_for :users

  get 'welcome/about'

  resources :wikis do
    resources :collaborators
  end

  resources :charges, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
