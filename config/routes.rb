Rails.application.routes.draw do
  get "logout" => "session#destroy", :as => "logout"
  get "login" => "session#new", :as => "login"
  post "login" => "session#create"
  get "signup" => "users#new", :as => "signup"
 
  resources :collections
  resources :users
  resources :notes
  get 'welcome/index'
  root :to => 'welcome#index'
  
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
