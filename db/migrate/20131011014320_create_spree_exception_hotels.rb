class CreateSpreeExceptionHotels < ActiveRecord::Migration
  def change
    create_table :spree_exception_hotels do |t|
      t.integer :product_id
      t.integer :room_id
      t.date :init_date
      t.date :end_date
      t.integer :plan_id
      t.float :adults
      t.float :children

      t.timestamps
    end
  end
end
