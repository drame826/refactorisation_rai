Rails.application.routes.draw do
  root to: "matches#index"
  resources :players
  resources :matches
  resources :leagues
  resources :clubs
end
