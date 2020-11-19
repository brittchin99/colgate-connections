Rails.application.routes.draw do
  get 'friend_request/create'
  devise_for :accounts, :controllers => {:registrations => "accounts"} 
    resources :accounts, :only => [:index, :show, :new, :create]
    resources :profiles, :only => [:index, :show, :update, :edit]
    resources :connections, :only => [:index, :show, :new, :create, :destroy]
    resources :homes, :only => [:index]
    resources :friend_requests, :only => [:index, :create, :destroy]
  root :to => "homes#index"
end
