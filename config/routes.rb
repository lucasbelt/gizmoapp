Rails.application.routes.draw do

  root "pages#home"

  get "pages/home", to: "pages#home"

  get '/about', to: "pages#about"

  get "/help", to: "pages#help"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :todos
  resources :recipes do
    resources :ccomments, only: [:create]
  end
  resources :products
  resources :resumes
  resources :ingredients, except: [:destroy]
  resources :tags

  get "/signingup", to: "chefs#new"
  resources :chefs, except: [:new]

  get "/signup", to: "users#new"
  resources :users, except: [:new]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/userarea", to: "cookies#new"
  post "/userarea", to: "cookies#create"
  delete "/userlogout", to: "cookies#destroy"

  mount ActionCable.server => '/cable'
end
