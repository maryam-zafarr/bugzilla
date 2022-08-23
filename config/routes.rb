# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users
      resources :projects do
        resources :bugs do
          post 'assign'
          post 'change'
        end
      end
    end
  end

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/all_projects', to: 'projects#all_projects_index', as: 'all_projects'

  devise_for :users
  resources :projects do
    resources :bugs do
      post 'assign'
      post 'change'
    end
  end

  unauthenticated :user do
    root 'home#index', as: :unauthenticated_root
  end

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
end
