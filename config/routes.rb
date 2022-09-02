Rails.application.routes.draw do
  resources :cars do
    member do
      delete :purge_content
    end
    resources :chargings, :only => [:create, :destroy]
  end
  patch '/cars/:car_id/chargings' => "chargings#update"
  devise_for :users, controllers: { registrations: 'users/registrations' } 
  devise_scope :user do
    get '/users' =>  'devise/registrations#new'
  end
  root 'cars#index'  
  get '/about' => "about#index"
end
