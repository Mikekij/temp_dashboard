Rails.application.routes.draw do
  resources :temperatures
  resources :thermometers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :temperatures, only: [:index, :create, :show, :update]
  end

end
