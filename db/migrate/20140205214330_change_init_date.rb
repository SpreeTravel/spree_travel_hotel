class ChangeInitDate < ActiveRecord::Migration
  def change
    rename_column :spree_rate_hotels, :init_date, :start_date
    rename_column :spree_exception_hotels, :init_date, :start_date
  end
end
