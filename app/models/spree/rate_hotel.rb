module Spree
  class RateHotel < ActiveRecord::Base
    belongs_to :product, :class_name => 'Spree::Product', :foreign_key => :product_id
  end
end
