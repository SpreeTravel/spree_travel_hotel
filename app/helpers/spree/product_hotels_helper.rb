module Spree
  module ProductHotelsHelper
      def stars(product)
        product.product_properties.where(:property_id => Spree::Property.find_by_name('stars')).first.value
      end 
      
      def rooms(product)
        product.variants.map{|v| v.option_values.map(&:name).select{|ov| ov.starts_with?('room')}}.flatten.uniq
      end        
  end
end
