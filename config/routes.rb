Rails.application.routes.draw do

  devise_for :accounts, :controllers => {:registrations => "accounts"} 
    resources :accounts, :only => [:index, :show, :new, :create]
    resources :profiles, :only => [:index, :show]
    resources :connections, :only => [:index, :show, :new, :create]
    
    root :to => "connections#index"

  
end
