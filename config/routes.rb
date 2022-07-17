Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users
  resources :projects do
    resources :bugs do
      post 'assign'
      post 'change'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
