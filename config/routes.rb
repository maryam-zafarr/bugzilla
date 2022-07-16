Rails.application.routes.draw do
  get 'bugs/index'
  get 'bugs/show'
  get 'bugs/edit'
  get 'bugs/update'
  root to: 'users#index'
  resources :projects
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
