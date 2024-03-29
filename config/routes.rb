require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    authenticate :user, lambda { |user| user.admin?} do
      get 'admin' => 'admin#index'
      resources :admin, only: :index do
        get 'page/:page', action: :index, on: :collection
      end
    end
    resources :cars do   
      member do
        delete :purge_content
      end  
      get 'page/:page', action: :index, on: :collection
      resources :repairs, except: :index
      resources :chargings, except: :index  
      resources :taxes, except: :index       
    end

    devise_for :users, controllers: { registrations: 'users/registrations' } 
    resources :users, only: [:destroy, :update]     
    devise_scope :user do
      get '/users' =>  'devise/registrations#new'
    end
    root 'cars#index'  
    get '/about' => "about#index" 
    get '/statistics' => 'statistics#index'
  end

  if Rails.env.production?
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  else
    mount Sidekiq::Web => '/sidekiq'
  end

end
