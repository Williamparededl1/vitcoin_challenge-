Rails.application.routes.draw do
  namespace :api do
    # Esta es la ruta correcta que necesitamos
    get '/addresses/:address', to: 'addresses#show'
  end

  namespace :api do
    get '/addresses/:address', to: 'addresses#show'
    # ----> AÑADE ESTA LÍNEA <----
    post '/transactions', to: 'transactions#create'
  end
end