class AddChildrenExtraToSpreeRateHotels < ActiveRecord::Migration
  def change
    add_column :spree_rate_hotels, :children_extra, :float    
  end
end
