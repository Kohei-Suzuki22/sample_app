Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  resources :users, except: [:update]
  patch "/users/:id/edit", to: "users#update"
  put "/users/:id/edit", to: "users#update"

  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :password_resets, only: [:new, :create, :edit, :update]
  post "/password_resets/new", to: "users#create"
  put "/password_resets/new", to: "users#create"
  post "/password_resets/:id/edit", to: "users#update"
  put "/password_resets/:id/edit", to: "users#update"
end
