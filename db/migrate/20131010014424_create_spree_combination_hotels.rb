class CreateSpreeCombinationHotels < ActiveRecord::Migration
  def change
    create_table :spree_combination_hotels do |t|
      t.integer :product_id
      t.integer :room_id
      t.date :init_date
      t.date :end_date
      t.integer :plan_id
      t.integer :adults
      t.integer :children
      t.float :price

      t.timestamps
    end
  end
end
