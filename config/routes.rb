Rails.application.routes.draw do
  get 'top_pages/index'
  get 'top_pages/:id', to: 'top_pages#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
