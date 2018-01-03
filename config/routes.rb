Rails.application.routes.draw do
  get 'wikis/create'

  get 'wikis/destroy'

  get 'wikis/edit'

  get 'wikis/index'

  get 'wikis/new'

  get 'wikis/show'

  get 'wikis/update'

  devise_for :users
  get 'welcome/index'

  get 'welcome/about'
  root to: 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
