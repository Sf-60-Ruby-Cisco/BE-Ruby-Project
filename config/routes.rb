Rails.application.routes.draw do
  resources :cars do
    member do
      delete :purge_content
    end
  end
  devise_for :users, controllers: { registrations: 'users/registrations' } 
  devise_scope :user do
    get '/users' =>  'devise/registrations#new'
  end
  root 'cars#index'  
  get '/about' => "about#index"

end
