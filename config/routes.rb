Rails.application.routes.draw do
  

  resources :forecasts
  root :to => "player_rounds#index"
  
  resources :player_rounds

  resources :rounds do
  	resources :player_rounds
  end

  resources :players do
  	resources :player_rounds
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
