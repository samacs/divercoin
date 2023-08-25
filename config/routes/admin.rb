# Admin routes

scope :admin, path: :admin do
  get '/settings', to: 'settings#edit'
  patch '/settings', to: 'settings#update'

  resources :currencies do
    collection do
      post '/import', to: 'currencies#import'
    end

    member do
      patch :active, to: 'currencies#active'
      patch :inactive, to: 'currencies#inactive'
    end
  end
end
