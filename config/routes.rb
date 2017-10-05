Rails.application.routes.draw do

  resources :results, :restaurant_challenges, :challenges, :user_challenges,:restaurants,:reviews,:users

  get '/', to: 'application#welcome'
  get '/home', to: 'users#home'
  get '/login', to: 'application#login'
  post '/log_user_in', to: 'application#log_user_in'
  get '/logout', to: 'application#logout'
  get '/review', to: 'reviews#new'
  post '/join_challenge', to: 'users#join_challenge'
  post '/logout', to: 'application#logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
