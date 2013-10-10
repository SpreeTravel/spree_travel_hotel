class ChangeAdultdForAdults < ActiveRecord::Migration
  def change
    rename_column :spree_rate_hotels, :adultd_three, :adults_three
  end
end
