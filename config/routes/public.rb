# Public routes
get '/sign-up', to: 'users#new'
post '/sign-up', to: 'users#create'

get '/sign-in', to: 'sessions#new'
post '/sign-in', to: 'sessions#create'

delete '/sign-out', to: 'sessions#destroy'
