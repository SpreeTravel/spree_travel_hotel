class RemoveRateException < ActiveRecord::Migration
  def change
    remove_column :spree_rate_hotels, :exceptions, :string
  end
end
