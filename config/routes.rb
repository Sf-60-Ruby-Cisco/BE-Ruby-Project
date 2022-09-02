Rails.application.routes.draw do
  resources :cars do
    resources :repairs, :only => [:create, :destroy]
    member do
      delete :purge_content
    end
    resources :chargings, :only => [:create, :destroy]
    
  end
  patch '/cars/:car_id/chargings' => "chargings#update"
  patch '/cars/:car_id/repairs' => "repairs#update"
  devise_for :users, controllers: { registrations: 'users/registrations' } 
  devise_scope :user do
    get '/users' =>  'devise/registrations#new'
  end
  root 'cars#index'  
  get '/about' => "about#index"
end
