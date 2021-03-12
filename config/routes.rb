Rails.application.routes.draw do
  get 'users/show', to: 'users#show'
  get 'users/edit', to: 'users#edit'
  patch 'users/edit', to: 'users#update'
  get 'users/relationships/followings', to: 'relationships#followings'
  get 'users/relationships/followers', to: 'relationships#followers'
  get 'relationships/follow', to: 'relationships#follow'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get     'login', to: 'devise/sessions#new'
    post    'login', to: 'devise/session#create'
    delete  'logout', to: 'devise/sessions#destroy'
    get     '/users/create', to: 'devise/registrations#new'
    get 'users/guest', to: 'users#guest'
  end

  root 'top_pages#index'

  resources :relationships, only: [:create, :destroy]
  
  resources :posts do
    resources :comments, only: [:create, :destroy] do
      resources :comment_likes, only: [:create, :destroy]
    end
  end

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
