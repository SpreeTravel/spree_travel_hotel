module Spree
  class VariantHotel < VariantAccommodation

    searchable :auto_index => true, :auto_remove => true do
      string :room
      string :plan
      integer :adults
      integer :children
      date :start_date
      date :end_date
      float :price
      integer :product_id
    end

    def room
      self.get_option_value_from_name('room')
    end

    def plan
      self.get_option_value_from_name('plan')
    end

  end
end
