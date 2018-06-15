Rails.application.routes.draw do
  
  get '/direct_message', to: 'bot_twitter#direct_message'
  get '/get_followers', to: 'bot_twitter#get_followers'
  get '/get_screen_name', to: 'bot_twitter#get_screen_name'
  get '/send_public_tweet', to: 'bot_twitter#send_public_tweet'
  get '/send_private_tweet', to: 'bot_twitter#send_private_tweet'
  resources :levels
  devise_for :users
  root 'home#index'
  resources :etablissements
  get 'etablissements/:id/likes', to: 'etablissements#likes', as: :likes
  resources :articles
  resources :filieres
  resources :niveaus
  resources :niveausups
  resources :associate_filiere_etabs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
  