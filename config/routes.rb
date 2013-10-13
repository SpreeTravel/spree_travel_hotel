Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :product_hotels
  end

  match 'admin/products/:permalink/rate_hotels' => 'admin/rate_hotels#index', :via => :get, :as => :hotel_rates
  match 'admin/products/:permalink/update_rate' => 'admin/rate_hotels#update', :via => :post, :as => :update_hotel_rate
  match 'admin/products/:permalink/new_rate' => 'admin/rate_hotels#new', :via => :get, :as => :new_hotel_rate
  match 'admin/products/:permalink/destroy_rate/:id' => 'admin/rate_hotels#destroy', :via => :delete, :as => :destroy_hotel_rate

  match 'admin/products/:permalink/new_exception' => 'admin/rate_hotels#new_exception', :via => :get, :as => :new_hotel_exception
  match 'admin/products/:permalink/destroy_exception/:id' => 'admin/rate_hotels#destroy_exception', :via => :post, :as => :destroy_hotel_exception
  match 'admin/products/:permalink/generate_combinations' => 'admin/rate_hotels#generate_combinations', :via => :get, :as => :generate_hotel_combinations

  match 'admin/products/:permalink/combination_hotels' => 'admin/rate_hotels#combinations', :via => :get, :as => :hotel_combinations
end
