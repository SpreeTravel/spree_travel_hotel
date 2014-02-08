class ChangeAdultsAndChildrenColumnToInteger < ActiveRecord::Migration
  def change
    remove_column :spree_exception_hotels, :adults
    remove_column :spree_exception_hotels, :children
    add_column :spree_exception_hotels, :adults, :integer
    add_column :spree_exception_hotels, :children, :integer
  end
end
