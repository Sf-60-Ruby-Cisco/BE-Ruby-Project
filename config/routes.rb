Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' } 
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/users' =>  'devise/registrations#new'
    get '/users/password' => 'devise/passwords#new'
  end
  root 'home#index'  

end
