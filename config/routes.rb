Rails.application.routes.draw do
  devise_for :accounts, :controllers => {:registrations => "accounts"} 
    resources :accounts, :only => [:new, :create]
    resources :profiles, :only => [:index, :show, :update, :edit]
    resources :connections, :only => [:index, :create, :destroy]
    resources :homes, :only => [:index]
    resources :conversations do
      resources :messages
    end
    resources :friend_requests, :only => [:index, :create, :destroy]
    get '/profiles/:id/settings', to: 'profiles#settings', as: 'settings'
  root :to => "homes#index"
end
