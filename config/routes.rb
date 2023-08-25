Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Public routes
  get '/sign-up', to: 'users#new'
  post '/sign-up', to: 'users#create'

  get '/sign-in', to: 'sessions#new'
  post '/sign-in', to: 'sessions#create'

  # Defines the root path route ("/")
  root 'static_pages#show', page: 'home'

  get '/*page', to: 'static_pages#show', as: :static_pages, constraints: lambda { |request|
                                                                           request.path.exclude?('/rails')
                                                                         }
end
