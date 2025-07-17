Rails.application.routes.draw do


  namespace :api do
    get '/addresses/:address', to: 'addresses#show'
    # ----> AÑADE ESTA LÍNEA <----
    post '/transactions', to: 'transactions#create'
  end
end