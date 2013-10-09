Spree::Core::Engine.routes.draw do
  namespace :spree do
    resources :hotel_combinations
  end

  namespace :spree do
    resources :hotel_rates
  end

  # Add your extension routes here
end
