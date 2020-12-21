Rails.application.routes.draw do
  get 'users/show', to: 'users#show'
  get 'users/edit', to: 'users#edit'
  patch 'users/edit', to: 'users#update'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get     'login', to: 'devise/sessions#new'
    post    'login', to: 'devise/session#create'
    delete  'logout', to: 'devise/sessions#destroy'
    get     '/users/create', to: 'devise/registrations#new'
  end

  root 'top_pages#index'
  resources :posts do
    get :search, on: :collection
    resources :comments, only: [:create, :destroy] do
      resources :comment_likes, only: [:create, :destroy]
    end
  end

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
