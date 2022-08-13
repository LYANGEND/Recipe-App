Rails.application.routes.draw do
  devise_for :users
  resources :recipes
  resources :foods
  resources :publics, only: [:index]
  resources :recipe_foods

  root "publics#index"
end
