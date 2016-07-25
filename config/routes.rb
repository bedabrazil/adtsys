Rails.application.routes.draw do

	resources :home do
		collection do
			get :search_models
			get :search_model
			get :search_model_years
			get :search_vehicle_prices
		end
	end
  root to: 'home#index'
end