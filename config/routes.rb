Rails.application.routes.draw do
  root "stations#index"
  resources :stations, only: [:create, :show]
end
