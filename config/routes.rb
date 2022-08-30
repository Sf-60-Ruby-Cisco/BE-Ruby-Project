Rails.application.routes.draw do
  resources :cars do
    resources :taxes
  end
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'home#index'
end
