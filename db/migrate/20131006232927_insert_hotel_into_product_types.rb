class InsertHotelIntoProductTypes < ActiveRecord::Migration
  def change
    Spree::ProductType.create(:name => 'Spree::ProductHotel', :presentation => 'Hotel', :partial_prefix => 'hotel', :enabled => true)
  end
end
