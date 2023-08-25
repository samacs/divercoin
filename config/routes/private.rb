# Private routes
get '/portfolio', to: 'balances#index'

resources :balances, only: %i[new create]
