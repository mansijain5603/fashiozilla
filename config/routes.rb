Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  
  
  root'products#index'
  resources :products  
  resources :profiles
    get "profiles/:id/edit" => "profiles#edit"
  resources :order_items
  get 'cart', to: 'cart#show' 


end
