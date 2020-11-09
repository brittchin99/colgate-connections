Rails.application.routes.draw do

  get 'homes/index'
  devise_for :accounts, :controllers => {:registrations => "accounts"} 
  resources :accounts, :only => [:index, :show, :new, :create]
  resources :profiles, :only => [:index, :show]
  resources :connections, :only => [:index, :show, :new, :create]
  resources :homes, :only => [:index]
  
  root :to => "homes#index"
end
