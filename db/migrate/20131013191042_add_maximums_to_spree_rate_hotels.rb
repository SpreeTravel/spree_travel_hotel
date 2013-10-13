class AddMaximumsToSpreeRateHotels < ActiveRecord::Migration
  def change
    add_column :spree_rate_hotels, :max_adults, :integer
    add_column :spree_rate_hotels, :max_children, :integer
  end
end
