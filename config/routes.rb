Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  
  get "/size/:size", to: "products#index"
  root'products#index'
  resources :products  
  resources :profiles
    get "profiles/:id/edit" => "profiles#edit"
  resources :order_items do
    member do
      post "implement"
    end
  end
  resources :orders
  resources :groups

  


end
