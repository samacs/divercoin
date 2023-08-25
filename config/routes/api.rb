# API routes

scope :api do
  resources :currencies, only: %i[] do
    post :refresh, on: :collection
  end
end
