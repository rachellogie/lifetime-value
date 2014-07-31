Rails.application.routes.draw do
  root "subscription_events#index"
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create"
  get "signout" => "sessions#destroy", as: :signout
  get "current_members" => "reports#current_members"
  get "lifetime_value" => "reports#lifetime_value"
end
