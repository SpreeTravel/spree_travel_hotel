class CreateSpreeRateHotels < ActiveRecord::Migration
  def change
    create_table :spree_rate_hotels do |t|
      t.integer :product_id
      t.integer :room_id
      t.date :init_date
      t.date :end_date
      t.integer :plan_id
      t.float :adults_one
      t.float :adults_two
      t.float :adultd_three
      t.float :children_one
      t.float :children_two
      t.float :adults_extra
      t.string :exceptions

      t.timestamps
    end
  end
end
