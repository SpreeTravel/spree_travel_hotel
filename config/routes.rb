Spree::Core::Engine.routes.draw do
  namespace :spree do
    resources :rate_hotels
  end

  # Add your extension routes here
end
