Rails.application.routes.draw do


  namespace :api do
    get '/addresses/:address', to: 'addresses#show'
    post '/transactions', to: 'transactions#create'
    get '/transactions/:uuid', to: 'transactions#show'
  end
end