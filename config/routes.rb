Rails.application.routes.draw do
  devise_for :accounts, :controllers => {:registrations => "accounts"} 
    resources :accounts, :only => [:new, :create]
    resources :profiles, :only => [:index, :show, :update, :edit]
    resources :connections, :only => [:index, :create, :destroy]
    resources :homes, :only => [:index]
    resources :settings, :only => [:index, :show, :update]
    resources :conversations do
      resources :messages
    end
    resources :friend_requests, :only => [:index, :create, :destroy]
    resources :blockages, :only => [:index, :create, :destroy]
    resources :notifications, :only => [:index]
    
    get 'profiles/:id/photos', :to => 'profiles#update_photos', :as => 'profiles_photo_update'

  root :to => "homes#index"
end
