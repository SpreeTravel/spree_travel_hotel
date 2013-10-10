Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :rate_hotels
    resources :product_hotels
  end

  match 'admin/products/:permalink/rate_hotels' => 'admin/rate_hotels#index', :via => :get, :as => :rates

  # Add your extension routes here
end
