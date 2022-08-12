Rails.application.routes.draw do
  devise_for :users
  resources :recipes
  resources :foods

  root "recipes#index"
end
