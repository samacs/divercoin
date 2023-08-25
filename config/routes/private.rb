# Private routes

get '/portfolio', to: 'balances#index'

resources :balances, only: %i[new create]

resources :currencies do
  collection do
    get :export
  end
end
