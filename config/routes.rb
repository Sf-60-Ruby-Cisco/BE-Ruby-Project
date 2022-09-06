Rails.application.routes.draw do
  resources :cars do
    member do
      delete :purge_content
    end
    resources :taxes
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }
  end
  devise_scope :user do
    get '/users' =>  'devise/registrations#new'
  end
  root 'cars#index'  
  get '/about' => "about#index"
end
